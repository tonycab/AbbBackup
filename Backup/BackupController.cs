using ABB.Robotics.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace AbbBackup.Backup
{
    public class BackupController
    {
        public ControllerInfo controllerInfo;

        public Controller controller;

        public RobotParams robotparam;

        public event Action<BackupController> BackupStart;

        public event Action<BackupController, BackupEventArgs> BackupCompleted;

        public UserInfo userInfo;

        public bool backupProgress { get; set; }

        public BackupCreator backupCreator { get; set; }


        internal BackupController()
        {
        }

        internal BackupController(ControllerInfo controllerInfo, string user, string password, string folderBackupPath)
        {

            this.controllerInfo = controllerInfo;
            userInfo = new UserInfo(user, password);
            this.robotparam = new RobotParams() { IP = controller.IPAddress.ToString(), User = user, Password = password, FolderBackup = folderBackupPath };
        }

        internal BackupController(ControllerInfo controllerInfo, RobotParams robotParam)
        {
            this.controllerInfo = controllerInfo;
            userInfo = new UserInfo(robotParam.User, robotParam.Password);
            robotparam = robotParam;
        }

        public void StartBackup()
        {
            try
            {
                var date = DateTime.Now;

                backupProgress = true;

                controller = Controller.Connect(controllerInfo, ConnectionType.Standalone);

                //Récupération du chemin du répertoire "HOME" sur la baie robot
                string home = controller.GetEnvironmentVariable("HOME");

                //Ajout de la méthode appeler lorsque la sauvegarde est terminé sur la baie robot
                BackupDownload backupCreatorDownload = new BackupDownload(this);

                controller.BackupCompleted += backupCreatorDownload.BackupEnd;

                controller.Logon(userInfo);

                //Demande des droits de lecture FTP
                controller.AuthenticationSystem.DemandGrant(Grant.ReadFtp);

                //Sélection du répertoire distant sur "HOME"
                controller.FileSystem.RemoteDirectory = home;

                //Suppression de l'ancienne sauvegarde
                if (controller.FileSystem.DirectoryExists("/BACKUP"))
                {
                    controller.FileSystem.RemoveDirectory("/BACKUP/");
                }

                Thread.Sleep(100);

                //Demande de sauvegarde
                controller.Backup(home + "/BACKUP/" + controller.Name);

                BackupStart?.Invoke(this);

                //Attente sauvegarde précédente terminé

                while (backupProgress == true)
                {
                    Thread.Sleep(1000);

                    var d = (DateTime.Now - date).TotalSeconds;

                    if (d > robotparam.TimeoutBackup)
                    {
                        Console.WriteLine($"Timeout backup");
                        controller?.Dispose();
                        backupProgress = false;
                        break;
                    }
                }


            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);

                BackupCompleted?.Invoke(this, null);
            }
        }

        public void CallEventBackupCompleted(BackupController backupCreator, BackupEventArgs e)
        {
            BackupCompleted?.Invoke(backupCreator, e);
        }

    }


}
