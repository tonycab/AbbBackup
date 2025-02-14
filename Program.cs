﻿using System;
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
        static private RobotList robots = new RobotList();

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

                    //Timeout de sauvegarde
                    case "--timeout":

                        if (args.Length > i + 1 & int.TryParse(args[i + 1], out int timeoutBackup))
                        {


                        }
                        break;

                    //répertoire de sauvegarde
                    case "--folder":

                        if (i != 0)
                        {
                            Console.WriteLine($" Erreur :");
                            Console.WriteLine($"    Argument --folder doit être en première position");
                            Console.ReadLine();
                            return;
                        }


                        if (args.Length > i + 1)
                        {
                            folderBackup = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));
                            Console.WriteLine($"Dossier de sauvegarde : {folderBackup}");

                        }
                        break;

                    case "--user":
                        user = args[i + 1];
                        break;

                    case "--password":
                        password = args[i + 1];
                        break;

                    case "--list":

                        if (args.Length > i + 1)
                        {
                            fileRobot = UNCPath(Environment.ExpandEnvironmentVariables(args[i + 1]));
                            Console.WriteLine($"Fichier UAS : {fileRobot}");

                            try
                            {
                                robots = RobotList.LoadToXml(fileRobot);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }

                        }
                        break;


                    //Aide
                    case "--help":
                        Console.WriteLine($" Backup Robot - Application for save the robots programs");
                        Console.WriteLine($" Option : ");
                        Console.WriteLine($"    --folder <path> : backup folder");
                        Console.WriteLine($"    --timeout <number> : timeout backup");
                        Console.WriteLine($"    --delete <number> : delete the old backups after days number ");
                        Console.WriteLine($"    --user <username> : user identification ");
                        Console.WriteLine($"    --password <password> : password identification ");
                        Console.WriteLine($"    --list <path> : file.xml UAS descriptor");
                        Console.ReadLine();
                        return;

                    default:
                        break;
                }

            }

            //Console.WriteLine($"------Backup------");
            Console.WriteLine("-".PadRight(60, '-'));
            Console.WriteLine("|ABB BACKUP".PadRight(59) + "|");
            Console.WriteLine("|Copyright © SIIF 2024".PadRight(59) + "|");
            Console.WriteLine($"|{Assembly.GetExecutingAssembly().GetName().Version.ToString().PadRight(58)}|");
            Console.WriteLine("|Application for save the robots programs".PadRight(59) + "|");
            Console.WriteLine("-".PadRight(60, '-'));

            Console.WriteLine($"Ctrl + c for exit application");


            //Recherche des robots présent sur le réseau
            scanner = new NetworkScanner();

            while (!ScanReseau(scanner) & Cancel == false)
            {
                Console.WriteLine($"No robot deteted, retry");
                Thread.Sleep(1000);
            }

            if (Cancel == true) goto Label;

            //Création du répertoire de sauvegarde horodaté
            FolderBackup = folderBackup + "/Backup/" + DateTime.Now.ToString("yyyy_MM_dd HH\\hmmm\\mss\\s");
            Directory.CreateDirectory(FolderBackup);


            //Itération des robots détecté pour affichage des robots présent sur le réseau
            Console.WriteLine("-".PadRight(103, '-'));

            foreach (ControllerInfo c in scanner.Controllers)
            {
                Console.WriteLine($"|{(c.Name.PadRight(16))} | {c.IPAddress.ToString().PadRight(16)} | {c.Id.PadRight(16)} | {c.VersionName.PadRight(16)} | {c.Availability.ToString().PadRight(16)}|");
            }
            Console.WriteLine("-".PadRight(103, '-'));

            Console.WriteLine($"");


            //Itération des robots détecté pour la sauvegarde
            foreach (ControllerInfo c in scanner.Controllers)
            {

                //Sauvegarde uniquemet des robots réels
                if (c.IsVirtual == false & c.Availability == Availability.Available)
                {

                    DateTime date = DateTime.Now;

                    ////Sauvegarde en cours
                    BackupInProgressNumber++;

                    Controller controller = null;

             
                    controller = Controller.Connect(c, ConnectionType.Standalone);

                    //Récupération du chemin du répertoire "HOME" sur la baie robot
                    string home = controller.GetEnvironmentVariable("HOME");

                    //Ajout de la methode appeler lorsque la sauvegarde est terminé sur la baie robot
                    controller.BackupCompleted += BackupEnd;

                    Console.WriteLine($"{c.Name} - {c.IPAddress} - Start backup");

                    //Recherche des identifiants dans un fichier xml
                    var r =  robots.Where((ro)=>ro.Id == c.SystemId ).Select((p)=>p).FirstOrDefault();

                    //Connection avec les identifiants du fichier xml
                    if (r != null)
                    {
                        controller.Logon(new UserInfo(r.User, r.Password));
                    }
                    //Connection au robot avec les identifiants par défaut
                    else if (user == "" || password == "")
                    {
                        controller.Logon(UserInfo.DefaultUser);
                    }
                    //Connection avec les identifiants en parametre
                    else
                    {
                        controller.Logon(new UserInfo(user, password));
                    }

                    //Demande des droits de lecture FTP
                    controller.AuthenticationSystem.DemandGrant(Grant.ReadFtp);

                    //Selection du répertoire distant sur "HOME"
                    controller.FileSystem.RemoteDirectory = home;

                    //Suppression de l'ancienne sauvegarde
                    if (controller.FileSystem.DirectoryExists("/BACKUP"))
                    {
                        controller.FileSystem.RemoveDirectory("/BACKUP/");
                    }

                    Thread.Sleep(100);

                    //Demande de sauvegarde
                    controller.Backup(home + "/BACKUP/" + controller.Name);


                    //Attente sauvegarde précédente terminé
                    while (BackupInProgressNumber > 0)
                    {

                        Thread.Sleep(1000);

                        var d = (DateTime.Now - date).TotalSeconds;

                        if (d > timeoutBackup)
                        {
                            Console.WriteLine($"Timeout backup");
                            controller?.Dispose();
                            BackupInProgressNumber--;
                            break;
                        }
                    }
                }
            }

            Label:

            //Toutes les sauvegardes sont terminées
            Console.WriteLine($"...Exit...");
            Thread.Sleep(2000);

        }

        static private void BackupEnd(object sender, BackupEventArgs e)
        {

            Task.Run(() =>
            {

                if (e.Succeeded)
                {
                    Controller controller = (Controller)sender;

                    Controller c = (Controller)sender;

                    controller.Logon(UserInfo.DefaultUser);

                    string home = controller.GetEnvironmentVariable("HOME");

                    controller.AuthenticationSystem.DemandGrant(Grant.ReadFtp);

                    controller.FileSystem.RemoteDirectory = FileSystemPath.Combine(home, "BACKUP");

                    controller.FileSystem.LocalDirectory = FolderBackup;

                    controller.FileSystem.GetDirectory(controller.Name);

                    //Renomme le repertoire avec l'ID
                    ControllerInfo ci = scanner.Controllers.Where(x => x.Name == controller.Name).FirstOrDefault();

                    string PathFolderBackup = FolderBackup + "\\" + controller.Name;


                    if (ci != null)
                    {
                        string PathFolderBackupID = FolderBackup + "\\" + ci.Id + "_" + DateTime.Now.ToString("yyyy_MM_dd_HH\\hmmm\\mss\\s");
                        ZipFile.CreateFromDirectory(PathFolderBackup, PathFolderBackupID + ".zip");
                    }
                    else
                    {
                        ZipFile.CreateFromDirectory(PathFolderBackup, PathFolderBackup + "_" + DateTime.Now.ToString("yyyy_MM_dd_HH\\hmmm\\mss\\s") + ".zip");
                    }

                    Directory.Delete(PathFolderBackup, true);


                    Console.WriteLine($"{c.Name} - Backup save in -> {PathFolderBackup} ");

                    BackupInProgressNumber--;
                }

            });
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


    }

}
