using ABB.Robotics.Controllers;
using AbbBackup.Params;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AbbBackup.Backup
{
    public class RobotBackup
    {
        public ControllerInfo ControllerInfo { get; set; }
        public RobotParams robotParams { get; set; }
        public string State { get; set; }


        public RobotBackup(ControllerInfo controllerInfo, RobotParams robotParams,string state)
        {
            ControllerInfo = controllerInfo;
            this.robotParams = robotParams;
            State = state;
        }

    }
}
