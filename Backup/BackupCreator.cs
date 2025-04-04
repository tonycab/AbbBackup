using ABB.Robotics.Controllers;
using ABB.Robotics.Controllers.Configuration;
using ABB.Robotics.Controllers.FileSystemDomain;
using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using AbbBackup.Backup;
using AbbBackup.Params;

namespace AbbBackup
{

    public class BackupCreator { 

        public DateTime Date { get; private set; }

        public List<BackupController> BackupControllers { get; set; } = new List<BackupController>();

        public BackupCreator()
        {
            Date = DateTime.Now;
        }

        public BackupController Factory(ControllerInfo controllerInfo, RobotParams robotParam)
        {
            BackupController rb = new BackupController(controllerInfo, robotParam);
            rb.backupCreator = this;
            BackupControllers.Add(rb);

            return rb;
        }

        public BackupController Factory(ControllerInfo controllerInfo, string user, string password, string folderBackupPath)
        {
            BackupController rb = new BackupController(controllerInfo, user, password, folderBackupPath);
            rb.backupCreator = this;
            BackupControllers.Add(rb);

            return rb;
        }
    }


 

}
