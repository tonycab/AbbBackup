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

namespace AbbBackup.Backup
{

    internal class BackupDownload
    {
        public BackupController backupCreator { get; set; }


        public BackupDownload(BackupController backupCreator)
        {
            this.backupCreator = backupCreator;
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

                        controller.Logon(backupCreator.userInfo);

                        string home = controller.GetEnvironmentVariable("HOME");

                        controller.AuthenticationSystem.DemandGrant(Grant.ReadFtp);

                        controller.FileSystem.RemoteDirectory = FileSystemPath.Combine(home, "BACKUP");


                        var FolderBackup = UNCPath(backupCreator.robotparam.FolderBackup) + "\\" + DateTime.Now.ToString("yyyy_MM_dd HH\\hmmm\\mss\\s");

                        Directory.CreateDirectory(FolderBackup);

                        controller.FileSystem.LocalDirectory = FolderBackup;

                        controller.FileSystem.GetDirectory(controller.Name);

                        var FolderDownload = FolderBackup + "\\" + controller.Name;


                        var NameFile = backupCreator.robotparam.NameFileBackup != "" ? backupCreator.robotparam.NameFileBackup : controller.Name;

                        string PathFolderBackup = FolderBackup + "\\" + NameFile + "_" + DateTime.Now.ToString("yyyy_MM_dd_HH\\hmmm\\mss\\s") + ".zip";


                        ZipFile.CreateFromDirectory(FolderDownload, PathFolderBackup);

                        Directory.Delete(FolderDownload, true);


                        //Console.WriteLine($"{c.Name} - Backup save in -> {PathFolderBackup} ");
                    }

                });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                backupCreator.CallEventBackupCompleted(backupCreator, e);
                backupCreator.backupProgress = false;
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
