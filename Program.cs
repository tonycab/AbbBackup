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

namespace AbbBackup
{
    internal class Program
    {

        static private uint BackupInProgressNumber = 0;
        static private string FolderBackup;
        static private NetworkScanner scanner;
        static private uint timeoutBackup = 60;
        static private string folderBackup = UNCPath(AssemblyDirectory);
        static private string fileRobot = UNCPath(AssemblyDirectory);
        static private string user = "";
        static private string password = "";
        static private RobotParamsList robots;
        static private bool allBackup;

        static private  bool ScanReseau(NetworkScanner scanner)
        {
            //Scan les robots présents sur le réseau
            scanner.Scan();
            Console.WriteLine($"Search robots");

            Thread.Sleep(5000);

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
                e.Cancel = true;
                Cancel = true;
            };

            //Gestion des arguments
            for (int i = 0; i < args.Length; i++)
            {
                switch (args[i].ToLower())
                {
                    //Suppression des anciennes sauvegarde
                    case "--delete":

                        if (args.Length > i + 1 & int.TryParse(args[i + 1], out int limit)) { }

                        if (Directory.Exists(folderBackup + "/Backup/"))
                        {
                            foreach (string dir in Directory.GetDirectories(folderBackup + "/Backup/"))
                            {
                                DateTime createdTime = new DirectoryInfo(dir).CreationTime;
                                if (createdTime < DateTime.Now.AddDays(-limit))
                                {
                                    Directory.Delete(dir, true);
                                }
                            }
                        }
                        break;


                    case "--all":
                        allBackup = true;

                        break;
           

                    case "--list":

                        if (args.Length > i + 1)
                        {
                            fileRobot = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));
                            
                            Console.WriteLine($"File configuration : {fileRobot}");

                            try
                            {

                                robots = RobotParamsList.LoadToXml(fileRobot);

                                robots.ForEach((p) => Console.WriteLine($"Robot {p.IP}" ));

                                Console.WriteLine($"Default folder backup :{robots.DefaultFolderBackup }");
                                Console.WriteLine($"TimeOut :{robots.DefaultTimeoutBackup}");



                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }

                        }
                        break;

                    case "--createxml":

                        if (args.Length > i + 1)
                        {
                            fileRobot = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));
                            Console.WriteLine($"Fichier UAS : {fileRobot}");


                            if (File.Exists(fileRobot))
                            {
                                robots = RobotParamsList.LoadToXml(fileRobot);
                            }
                            else
                            {
                                robots = new RobotParamsList();
                            }

                            //Recherche des robots présent sur le réseau
                            scanner = new NetworkScanner();

                            while (!ScanReseau(scanner))
                            {
                                Console.WriteLine($"No robot deteted, retry");
                                Thread.Sleep(1000);
                            }

                            foreach (ControllerInfo c in scanner.Controllers)
                            {
                                if (c.IsVirtual == false & c.Availability == Availability.Available)
                                {
                                    robots.Add(robots.GetDefaultRobotParams(c));

                                    Console.WriteLine($"Robot {c.Name} add in list");
                                }
                            }
                             if (robots.Count > 0) robots.SaveFromXml(fileRobot);
                        }

                        return;


                    //Aide
                    case "--help":
                        Console.WriteLine($" Backup Robot - Application for save the robots programs");
                        Console.WriteLine($" Option : ");
                        Console.WriteLine($"    --All  : backup all robot");
                        Console.WriteLine($"    --list <path> : config.xml");
                        Console.WriteLine($"    --listadd <path> : create config.xml");
                        Console.ReadLine();
                        return;

                    default:
                        break;
                }

            }

            //Console.WriteLine($"------Backup------");
            Console.WriteLine("-".PadRight(60, '-'));
            Console.WriteLine("|ABB BACKUP".PadRight(59) + "|");
            Console.WriteLine("|Copyright © SIIF 2025".PadRight(59) + "|");
            Console.WriteLine($"|{Assembly.GetExecutingAssembly().GetName().Version.ToString().PadRight(58)}|");
            Console.WriteLine("|Application for save the robots programs".PadRight(59) + "|");
            Console.WriteLine("-".PadRight(60, '-'));

            Console.WriteLine($"Ctrl + c for exit application");


            //Recherche des robots présent sur le réseau
            scanner = new NetworkScanner();

            while (!ScanReseau(scanner) & Cancel == false)
            {
                Console.WriteLine($"No robot detected, retry");
                Thread.Sleep(1000);
            }


            //Liste les robot présent sur le réseau et dans le fichier UAS
            var robotsasauvegarder = from controller in scanner.Controllers
                         join paramController in robots on controller.SystemId equals paramController.Id into gj
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
                    $" {(c.Params !=null || allBackup ? "Backup" : "No Backup").PadRight(16)}|" +
                    $"");
            }
            Console.WriteLine("-".PadRight(125, '-'));

            Console.WriteLine($"");


            BackupCreator backupCreator = new BackupCreator();

            //Itération des robots détecté pour la sauvegarde
            foreach (var c in robotsasauvegarder)
            {
                RobotParams param = c.Params;
                if (allBackup && c.Params ==null)
                {
                    param = robots.GetDefaultRobotParams();
                }

                if(c.Params == null)
                {
                    continue;
                }

                BackupController backupController = backupCreator.Factory(c.controller, param);
                backupController.BackupStart += (p) => Console.WriteLine($"{p.robotparam.NameFileBackup} - Start backup");
                backupController.BackupCompleted += (p,e) => Console.WriteLine($"{p.robotparam.NameFileBackup} - Backup completed");
                backupController.StartBackup();

            }


            Label:

            //Toutes les sauvegardes sont terminées
            Console.WriteLine($"...Exit...");
            Thread.Sleep(2000);

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
