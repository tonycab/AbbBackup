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

namespace AbbBackup
{
    internal class Program
    {

        static private NetworkScanner scanner;
        static private string confFile;
        static private RobotParamsList robotsParams;
        static private bool allBackup;

        static string defaultConfFile = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "SIIF", "AbbBackup", "conf.xml");
        static private bool ScanReseau(NetworkScanner scanner, int timeScan)
        {
            //Scan les robots présents sur le réseau
            scanner.Scan();
            Console.WriteLine($"Search robots");

            Thread.Sleep(timeScan);

            //Fin du programme si pas de robot détecté
            if (scanner.Controllers.Where(p => !p.IsVirtual).ToList().Count() == 0)
            {
                return false;
            }
            return true;
        }

        static void Main(string[] args)
        {

            //Pour quitter l'appli
            bool Cancel = false;
            Console.CancelKeyPress += delegate (object sender, ConsoleCancelEventArgs e)
            {
                Console.WriteLine($"=>Quit");
                e.Cancel = true
                Cancel = true;
            };

            //Gestion des arguments
            for (int i = 0; i < args.Length; i++)
            {
                switch (args[i].ToLower())
                {
                    //Sauvegarde de tout les robots présent sur le réseau
                    case "--all":

                        allBackup = true;

                        break;

                    //Spécifie un fichier de configuration
                    case "--conf":

                        try
                        {
                            if (args.Length > i + 1)
                            {
                                confFile = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));

                                Console.WriteLine($"File configuration : {confFile}");

                                robotsParams = RobotParamsList.LoadToXml(confFile);
                            }
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                        }
                        break;

                    //Ajout les robots présents au fichier de configuration
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
                            Console.WriteLine($"Search robots for adding to file config.xml");


                            //Recherche des robots présent sur le réseau
                            scanner = new NetworkScanner();

                            while (!ScanReseau(scanner, robotsParams.TimeScan))
                            {
                                Console.WriteLine($"No robot deteted, retry");
                                Thread.Sleep(1000);
                            }

                            foreach (ControllerInfo c in scanner.Controllers)
                            {
                                if (c.IsVirtual == false & c.Availability == Availability.Available)
                                {
                                    if (robotsParams.Add(robotsParams.GetDefaultRobotParams(c)))
                                    {

                                        Console.WriteLine($"Robot {c.Name} add in file conf.xml");
                                    }
                                }

                            }
                            if (robotsParams.Count > 0) robotsParams.SaveFromXml(confFile);

                            Console.WriteLine($"Custom the file conf.xml with user, password,  folder backup directory");

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

            CopyrigthMenu();


            //Aucun fichier de configuration chargée
            if (robotsParams == null)
            {

                if (!File.Exists(defaultConfFile))
                {
                    Directory.CreateDirectory(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "SIIF", "AbbBackup"));

                    robotsParams = new RobotParamsList();
                    robotsParams.SaveFromXml(defaultConfFile);

                    Console.WriteLine($"Création d'un fichier de configuration : {defaultConfFile}");
                }

                robotsParams = RobotParamsList.LoadToXml(defaultConfFile);

                Console.WriteLine($"Chargement du fichier de configuration : {defaultConfFile}");
                
            }

            Console.WriteLine($"Répertoire de sauvegarde par défaut : {robotsParams.DefaultFolderBackup}");
           

            //Recherche des robots présent sur le réseau
            scanner = new NetworkScanner();
            while (!ScanReseau(scanner, robotsParams.TimeScan) & Cancel == false)
            {
                Console.WriteLine($"No robot detected, retry");
                Thread.Sleep(1000);
            }


            //Liste les robot présent sur le réseau et dans le fichier de configuration
            var robotsasauvegarder = from controller in scanner.Controllers
                                     join paramController in robotsParams on controller.SystemId equals paramController.Id into gj
                                     from Params in gj.DefaultIfEmpty()
                                     select new
                                     {
                                         controller,
                                         Params
                                     };


            //Itération des robots détecté pour affichage des robots présent sur le réseau
            Console.WriteLine("-".PadRight(125, '-'));
            foreach (var c in robotsasauvegarder)
            {
                Console.WriteLine(
                    $"|{(c.controller.Name.PadRight(16))} |" +
                    $" {c.controller.IPAddress.ToString().PadRight(16)} |" +
                    $" {c.controller.Id.PadRight(32)} |" +
                    $" {c.controller.VersionName.PadRight(10)} |" +
                    $" {c.controller.Availability.ToString().PadRight(16)}|" +
                    $" {((c.Params != null || allBackup) && !c.controller.IsVirtual ? "Backup" : "No Backup").PadRight(16)}|" +
                    $"");
            }
            Console.WriteLine("-".PadRight(125, '-'));
            Console.WriteLine($"");

            //Itération des robots détecté pour la sauvegarde
            BackupCreator backupCreator = new BackupCreator();
            foreach (var c in robotsasauvegarder)
            {
                RobotParams param = c.Params;
                if (allBackup && c.Params == null)
                {
                    param = robotsParams.GetDefaultRobotParams(c.controller);
                }

                if (param == null || c.controller.IsVirtual)
                {
                    continue;
                }

                BackupController backupController = backupCreator.Factory(c.controller, param);
                backupController.BackupStart += (p) => Console.WriteLine($"{p.robotparam.NameFileBackup} - Start backup");
                backupController.BackupCompleted += (p, e) => Console.WriteLine($"{p.robotparam.NameFileBackup} - Backup completed -> {p.robotparam.FolderBackup}");
                backupController.StartBackup();

                if (param.DelayDeleteFile != -1)
                {
                    RemoveFilesDirectory(param.FolderBackup, param.DelayDeleteFile);
                }

            }


            Label:

            //Toutes les sauvegardes sont terminées
            Console.WriteLine($"...Exit...");
            Thread.Sleep(2000);

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
                    }
                }
            }
        }



    }

}
