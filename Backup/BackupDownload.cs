using ABB.Robotics.Controllers.FileSystemDomain;
using ABB.Robotics.Controllers;
using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Win32;
using AbbBackup.Params;
using AbbBackup.Logs;

namespace AbbBackup.Backup
{

    internal class BackupDownload
    {
        public BackupController BackupController { get; set; }


        public BackupDownload(BackupController backupCreator)
        {
            this.BackupController = backupCreator;
        }

        public async void BackupEnd(object sender, BackupEventArgs e)
        {
            try
            {
                await Task.Run(() =>
                {


                    if (e.Succeeded)
                    {

                        Controller controller = (Controller)sender;

                        LogsManager.Add(EnumCategory.Info, "backup", $"Connexion to controller : {controller.Name}");

                        controller.Logon(BackupController.userInfo);

                        string home = controller.GetEnvironmentVariable("HOME");

                        LogsManager.Add(EnumCategory.Info, "backup", $"Request grant Ftp : {controller.Name}");

                        controller.AuthenticationSystem.DemandGrant(Grant.ReadFtp);

                        controller.FileSystem.RemoteDirectory = FileSystemPath.Combine(home, "BACKUP");

                        var FolderBackup = UNCPath(BackupController.robotparam.FolderBackup) + "\\" + BackupController.backupCreator.Date.ToString("yyyy_MM_dd HH\\hmmm\\mss\\s");

                        LogsManager.Add(EnumCategory.Info, "backup", "Creating backup folder");

                        Directory.CreateDirectory(FolderBackup);

                        //controller.FileSystem.LocalDirectory = FolderBackup;

                        controller.FileSystem.LocalDirectory = Path.GetTempPath();

                        LogsManager.Add(EnumCategory.Info, "backup", "Download backup from robot started");

                        controller.FileSystem.GetDirectory(controller.Name);

                        LogsManager.Add(EnumCategory.Info, "backup", "Download backup from robot ended");

                        var FolderDownload = controller.FileSystem.LocalDirectory + "\\" + controller.Name;

                        var NameFile = BackupController.robotparam.NameFileBackup != "" ? BackupController.robotparam.NameFileBackup : controller.Name;

                        string PathFolderBackup = FolderBackup + "\\" + NameFile + "_" + BackupController.backupCreator.Date.ToString("yyyy_MM_dd_HH\\hmmm\\mss\\s") + ".zip";

                        string PathFolderBackupZip = controller.FileSystem.LocalDirectory + "\\" + NameFile + "_" + BackupController.backupCreator.Date.ToString("yyyy_MM_dd_HH\\hmmm\\mss\\s") + ".zip";


                        LogsManager.Add(EnumCategory.Info, "backup", "Start folder compressing");

                        ZipFile.CreateFromDirectory(FolderDownload, PathFolderBackupZip);

                        LogsManager.Add(EnumCategory.Info, "backup", "Folder compressing ended");

                        File.SetCreationTime(PathFolderBackupZip, BackupController.backupCreator.Date);

                        File.Move(PathFolderBackupZip, PathFolderBackup);

                        LogsManager.Add(EnumCategory.Info, "backup", "Changing date create time file");

                        Directory.Delete(FolderDownload, true);


                        //Console.WriteLine($"{c.Name} - Backup save in -> {PathFolderBackup} ");
                    }

                });
            }
            catch (Exception ex)
            {
                LogsManager.Add(EnumCategory.Error,"backup", ex.Message);    
            }
            finally
            {
                BackupController.CallEventBackupCompleted(BackupController, e);
                BackupController.backupProgress = false;
            }
        }

        private static string UNCPath(string path)
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
