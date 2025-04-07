using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using ABB.Robotics.Controllers;
using ABB.Robotics.Controllers.Discovery;
using ABB.Robotics.Controllers.FileSystemDomain;
using System.IO.Compression;
using ABB.Robotics.Controllers.MotionDomain;
using Microsoft.Win32;
using System.Reflection.Emit;
using AbbBackup.Backup;
using System.Diagnostics;
using System.Net.NetworkInformation;
using System.Diagnostics.Eventing.Reader;
using AbbBackup.Params;
using AbbBackup.Logs;
using AbbBackup.Report;
using System.Runtime.InteropServices.WindowsRuntime;


namespace AbbBackup
{
    internal class Program
    {

        static private NetworkScanner scanner;
        static private string confFile;
        static private RobotParamsList robotsParams;
        static private bool onlineOnly;

        static string defaultConfFile = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "SIIF", "AbbBackup", "conf.xml");
        static string defaultMailsFile = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "SIIF", "AbbBackup", "mail.xml");
        static string defaultLogFile = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "SIIF", "AbbBackup\\Logs");



        static void Main(string[] args)
        {

            LogsManager.OnLogAdd += ConsoleWrite;
            LogsManager.OnLogAdd += WriteLogFile;

            LogsManager.Add(EnumCategory.Info, "Start application", "Start application");


            //Pour quitter l'appli
            bool Cancel = false;
            Console.CancelKeyPress += delegate (object sender, ConsoleCancelEventArgs e)
            {
                Console.WriteLine($"=>Quit");
                e.Cancel = true;
                Cancel = true;
            };

            //Gestion des arguments
            for (int i = 0; i < args.Length; i++)
            {
                switch (args[i].ToLower())
                {
                    //Sauvegarde uniquement les robots présent sur le réseau
                    case "--online":

                        onlineOnly = true;

                        LogsManager.Add(EnumCategory.Process, "Parameters", "Save online robot only");

                        break;

                    //Spécifie un fichier de configuration
                    case "--conf":

                        try
                        {
                            if (args.Length > i + 1)
                            {
                                confFile = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));

                                LogsManager.Add(EnumCategory.Info, "Parameters", $"Load config file {confFile}");

                                robotsParams = RobotParamsList.LoadToXml(confFile);

                                LogsManager.Add(EnumCategory.Process, "Parameters", $"Config file loaded {confFile}");
                            }
                        }
                        catch (Exception ex)
                        {
                            LogsManager.Add(EnumCategory.Error, "Parameters", $"Config file no loaded {confFile}");

                        }
                        break;

                    //Ajout les robots présents sur le réseau au fichier de configuration
                    case "--addconf":
                        try
                        {
                            if (args.Length > i + 1)
                            {
                                confFile = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));
                            }
                            else
                            {
                                confFile = defaultConfFile;
                            }


                            if (File.Exists(confFile))
                            {
                                robotsParams = RobotParamsList.LoadToXml(confFile);
                            }
                            else
                            {
                                robotsParams = new RobotParamsList();
                            }

                            CopyrigthMenu();

                            LogsManager.Add(EnumCategory.Process, "Parameters", $"Search robots for adding to file config.xml");

                            //Recherche des robots présent sur le réseau
                            scanner = new NetworkScanner();

                            Task.Delay(5000).Wait();

                            while (!ScanReseau(scanner, robotsParams.TimeScan))
                            {
                                if (Cancel == true) goto Label;
                                LogsManager.Add(EnumCategory.Error, "Controller", $"No robot deteted, retry");
                                Thread.Sleep(1000);
                            }

                            foreach (ControllerInfo c in scanner.Controllers)
                            {
                                if (c.IsVirtual == false & c.Availability == Availability.Available)
                                {
                                    if (robotsParams.Add(robotsParams.GetDefaultRobotParams(c)))
                                    {
                                        LogsManager.Add(EnumCategory.Process, "Controller", $"Robot {c.Name} add in file conf.xml");

                                    }
                                }

                            }
                            if (robotsParams.Count > 0) robotsParams.SaveFromXml(confFile);

                            LogsManager.Add(EnumCategory.Process, "Controller", $"Custom the file conf.xml with user, password,  folder backup directory");

                            Process.Start("explorer.exe", Directory.GetParent(confFile).FullName);
                        }

                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                        }
                        return;

                    //Aide
                    case "--help":
                        Console.WriteLine($" Backup Robot - Application for save the robots programs");
                        Console.WriteLine($" Option : ");
                        Console.WriteLine($"    --All  : backup all robot");
                        Console.WriteLine($"    --conf <path> : config.xml");
                        Console.WriteLine($"    --addconf  : add robot to default config.xml");
                        Console.WriteLine($"    --addconf <path> : add robot to path config.xml");
                        Console.ReadLine();
                        return;

                    default:
                        break;
                }
            }

            //Affichage du menu copyrigth
            CopyrigthMenu();


            //Chargement du fichier de configuration
            if (robotsParams == null)
            {
                //Creation du fichier de configuration par défaut
                if (!File.Exists(defaultConfFile))

                {
                    LogsManager.Add(EnumCategory.Info, "Configuration", "no present config file");

                    Directory.CreateDirectory(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "SIIF", "AbbBackup"));

                    robotsParams = new RobotParamsList();
                    robotsParams.Mails.Add(new Mail());
                    robotsParams.SaveFromXml(defaultConfFile);

                    LogsManager.Add(EnumCategory.Info, "Configuration", $"Create config file to {defaultConfFile}");

                }

                //Chargement du fichier de configuration
                robotsParams = RobotParamsList.LoadToXml(defaultConfFile);

                LogsManager.Add(EnumCategory.Process, "Configuration", $"load config file to {defaultConfFile}");

            }


            scanner = new NetworkScanner();

            ControllerInfo[] ci;

            //Sauvegarde uniquement les robots de la listes
            if (!onlineOnly)
            {

                List<ControllerInfo> controllerInfos = new List<ControllerInfo>();

                //Recherche des robots présent dans le fichier
                foreach (var robot in robotsParams)
                {
                    try
                    {
                        LogsManager.Add(EnumCategory.Process, "Ping", $"Ping : {robot.IP}");

                        Ping pingSender = new Ping();
                        PingReply reply = pingSender.Send(robot.IP);

                        if (reply.Status != IPStatus.Success)
                        {
                            LogsManager.Add(EnumCategory.Error, "Ping", $"Ping : {robot.IP} -> no response");

                            continue;
                        }
                        else
                        {
                            LogsManager.Add(EnumCategory.Process, "Ping", $"Ping : {robot.IP} -> response ok");
                        }

                        if (scanner.TryFind(robot.Id, robotsParams.TimeScan, robotsParams.RetryScan, out ControllerInfo cf))
                        {
                            LogsManager.Add(EnumCategory.Process, "Identification", $"Robot found : {robot.IP} | {cf.Name} | {cf.VersionName}");

                            controllerInfos.Add(cf);
                        }
                        else
                        {
                            LogsManager.Add(EnumCategory.Error, "Identification", $"Robot : {robot.IP} no found");
                        }

                    }
                    catch (Exception ex)
                    {
                        LogsManager.Add(EnumCategory.Error, "Exception", $"{ex.Message}");

                    }
                }
                ci = controllerInfos.ToArray();

            }
            //Sauvegarde des robots en ligne
            else
            {

                //Recherche des robots présent sur le réseau
                while (!ScanReseau(scanner, robotsParams.TimeScan) & Cancel == false)
                {
                    LogsManager.Add(EnumCategory.Process, "Scan", $"no robot detected, retry");
                    Thread.Sleep(1000);
                }

                ci = scanner.GetControllers(NetworkScannerSearchCriterias.Real);
            }


            //Liste les robot présent sur le réseau et dans le fichier de configuration
            var robotsasauvegarder = from controller in ci
                                     join paramController in robotsParams on controller.SystemId equals paramController.Id into gj
                                     from Params in gj.DefaultIfEmpty()
                                     select new
                                     {
                                         controller,
                                         Params
                                     };


            //Itération des robots détecté pour affichage des robots présent sur le réseau


            Console.WriteLine($"");
            Console.WriteLine("-".PadRight(120, '-'));
            foreach (var c in robotsasauvegarder)
            {
                Console.WriteLine(
                    $"|{(c.controller.Name.PadRight(16))} |" +
                    $" {c.controller.IPAddress.ToString().PadRight(16)} |" +
                    $" {c.controller.Id.PadRight(28)} |" +
                    $" {c.controller.VersionName.PadRight(10)} |" +
                    $" {c.controller.Availability.ToString().PadRight(12)}|" +
                    $" {((c.Params != null || onlineOnly) && !c.controller.IsVirtual ? "Backup" : "No Backup").PadRight(12)}|" +
                    $"");



            }
            Console.WriteLine("-".PadRight(120, '-'));
            Console.WriteLine($"");

            List<RobotBackup> listerob = new List<RobotBackup>();

            //Itération des robots détecté pour la sauvegarde
            BackupCreator backupCreator = new BackupCreator();
            foreach (var c in robotsasauvegarder)
            {

                RobotParams param = c.Params;

                var state = (c.Params != null || onlineOnly) && !c.controller.IsVirtual ? "Echec" : "No Backup";

                var rb = new RobotBackup(c.controller, c.Params, $"{state}");

                listerob.Add(rb);


                if (onlineOnly && c.Params == null)
                {
                    param = robotsParams.GetDefaultRobotParams(c.controller);
                }

                if (param == null || c.controller.IsVirtual)
                {
                    continue;
                }

                if (!Directory.Exists(param.FolderBackup)) param.FolderBackup = robotsParams.DefaultFolderBackup;

                BackupController backupController = backupCreator.Factory(c.controller, param);

                backupController.BackupStart += (p) => LogsManager.Add(EnumCategory.Process, "Backup", $"{p.robotparam.NameFileBackup} - Start backup");
                backupController.BackupCompleted += (p, e) => LogsManager.Add(EnumCategory.Process, "Backup", $"{p.robotparam.NameFileBackup} - Backup completed -> {p.robotparam.FolderBackup}");

                if (backupController.StartBackup())
                {

                    rb.State = "Succes";

                }

                if (param.DelayDeleteFile != -1)
                {
                    RemoveFilesDirectory(param.FolderBackup, param.DelayDeleteFile);

                }

            }


            //Send report to mail
            foreach (var mail in robotsParams.Mails)
            {
                if (!mail.Actived) continue;

                List<Log> logError;

                string subjectMail;
                if (mail.AllLogs)
                {
                    logError = LogsManager.GetLogs().ToList();
                    subjectMail = "Backup logs";
                }
                else
                {
                    logError = LogsManager.GetLogs().Where((l) => l.Category == EnumCategory.Error).ToList();
                    subjectMail = "Backup Error logs";
                }

                if (logError.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();



                    sb.AppendLine(FormatHTML(listerob, LogsManager.GetLogs().ToList()));


                    IReport mr = new MailReport()
                    {
                        Mail = mail,
                        AdressMailFrom = robotsParams.Mails.AdressMailFrom,
                        NameFrom = robotsParams.Mails.NameFrom,
                        HostSmtp = robotsParams.Mails.HostSmtp,
                        PortSmtp = robotsParams.Mails.PortSmtp,
                        CredentialName = robotsParams.Mails.CredentialName,
                        Subject = subjectMail,
                        Content = sb.ToString(),
                    };


                    if (mr.Send())
                    {
                        LogsManager.Add(EnumCategory.Process, "Report", $"Send report to mail {mail.AdressMailTo}");
                    }
                    else
                    {
                        LogsManager.Add(EnumCategory.Error, "Report", $"Error Send report to mail {mail.AdressMailTo}");
                    }
                }
            }



            Label:

            //Toutes les sauvegardes sont terminées
            Console.WriteLine($"...Exit...");
            Thread.Sleep(2000);

        }

        private static string FormatHTML(List<RobotBackup> rb, List<Log> lm)
        {
            string htmlTable = $"<div><h1>Rapport de sauvegarde robots du {DateTime.Now.ToString()}</h1>";


            // Génération du tableau robot
            htmlTable += "<div><h2 style='text-decoration: underline;'>Etat des sauvegardes robots</h2><p>Liste des robots :</p><table border='1' cellpadding='5' cellspacing='0'><tr><th>ID</th><th>Identifiant</th><th>Version</th><th>Répertoire de sauvegarde</th><th>Etat</th></tr>";


            foreach (var cell in rb)
            {
                string color = "white";
                if (cell.State == "Echec")
                {
                    color = "red";
                }
                else if (cell.State == "Succes")
                {
                    color = "green";
                }

                htmlTable += "<tb>";
                htmlTable += $"<td>{cell.ControllerInfo.Id}</td>";
                htmlTable += $"<td>{cell.ControllerInfo.Name}</td>";
                htmlTable += $"<td>{cell.ControllerInfo.VersionName}</td>";
                htmlTable += $"<td>{cell.robotParams.FolderBackup}</td>";
                htmlTable += $"<td style='background-color:{color};'>{cell.State}</td>";
                htmlTable += "</tb>";
            }

            htmlTable += "</table></div>";


            // Génération du tableau robot
            htmlTable += "<div><h2 style='text-decoration: underline;'>Rapport des Logs</h2><p>Liste des logs :</p><table border='1' cellpadding='5' cellspacing='0'><tr><th>Date</th><th>Categorie</th><th>Type</th><th>Description</th></tr>";

            foreach (var cell in lm.Where((l)=> l.Category == EnumCategory.Process || l.Category == EnumCategory.Error))
            {
                string color = "white";
                if (cell.Category == EnumCategory.Error)
                {
                    color = "red";
                }

                htmlTable += "<tr style='background-color:" + color + ";'>";
                htmlTable += $"<td>{cell.Date}</td>";
                htmlTable += $"<td>{cell.Category}</td>";
                htmlTable += $"<td>{cell.Type}</td>";
                htmlTable += $"<td>{cell.Description}</td>";
                htmlTable += "</tr>";
            }

            htmlTable += $"</table><strong>Rapport édité automatiquement par l'application AbbBackup le {DateTime.Now.ToString()}</strong></div>";

            htmlTable += "<div></div>";

            return htmlTable;
        }



        //Affiche des messages dans la console
        private static void ConsoleWrite(Log log)
        {

            if (log.Category == EnumCategory.Process || log.Category == EnumCategory.Error)
            {
                Console.WriteLine(
                    $"|{(log.Category.ToString().PadRight(10))} |" +
                    $" {log.Type.PadRight(16)} |" +
                    $" {log.Description}");
            }
        }

        static private bool ScanReseau(NetworkScanner scanner, int timeScan)
        {
            //Scan les robots présents sur le réseau
            scanner.Scan();
            LogsManager.Add(EnumCategory.Info, "Scan", $"Search robot online");

            Thread.Sleep(timeScan);

            //Fin du programme si pas de robot détecté
            if (scanner.Controllers.Where(p => !p.IsVirtual).ToList().Count() == 0)
            {
                return false;
            }

            return true;
        }

        private static void WriteLogFile(Log log)
        {

            Directory.CreateDirectory(defaultLogFile);

            using (StreamWriter fs = new StreamWriter(defaultLogFile + "\\Logs_" + DateTime.Today.ToString("yyyyMMdd") + ".log", true))
            {
                fs.WriteLine(log.ToString());
            }
        }

        static public void CopyrigthMenu()
        {
            //Console.WriteLine($"------Backup------");
            Console.WriteLine("-".PadRight(60, '-'));
            Console.WriteLine("|ABB BACKUP".PadRight(59) + "|");
            Console.WriteLine("|Copyright © SIIF 2025".PadRight(59) + "|");
            Console.WriteLine($"|{Assembly.GetExecutingAssembly().GetName().Version.ToString().PadRight(58)}|");
            Console.WriteLine("|Application for save the robots programs".PadRight(59) + "|");
            Console.WriteLine("-".PadRight(60, '-'));
            Console.WriteLine($"Ctrl + c for exit application");
        }

        public static string AssemblyDirectory
        {
            get
            {
                string codeBase = Assembly.GetExecutingAssembly().Location;// .CodeBase;
                UriBuilder uri = new UriBuilder(codeBase);
                string path = Uri.UnescapeDataString(uri.Path);
                return Path.GetDirectoryName(path);
            }
        }


        public static string UNCPath(string path)
        {
            if (!path.StartsWith(@"\\"))
            {
                using (RegistryKey key = Registry.CurrentUser.OpenSubKey("Network\\" + path[0]))
                {
                    if (key != null)
                    {
                        return key.GetValue("RemotePath").ToString() + path.Remove(0, 2).ToString();
                    }
                }
            }
            return path;
        }

        public static void RemoveFilesDirectory(string path, int delay)
        {

            if (Directory.Exists(path))
            {
                foreach (string dir in Directory.GetDirectories(path))
                {
                    DateTime createdTime = new DirectoryInfo(dir).CreationTime;
                    if (createdTime < DateTime.Now.AddDays(-delay))
                    {
                        Directory.Delete(dir, true);
                        LogsManager.Add(EnumCategory.Info, "Delete File", $" Remove folder -> {dir}");

                    }
                }
            }
        }



    }

}
