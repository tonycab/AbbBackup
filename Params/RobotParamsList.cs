using ABB.Robotics.Controllers;
using AbbBackup.Logs;
using AbbBackup.Report;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace AbbBackup.Params
{
    public class RobotParamsList : List<RobotParams>
    {
        public string DefaultUser { get; set; } = "Default User";
        public string DefautlPassword { get; set; } = "robotics";
        public string DefaultFolderBackup { get; set; } = RobotParams.GetDefaultPath();
        public int DefaultTimeoutBackup { get; set; } = 300;
        public int DefaultDelayDeleteFile { get; set; } = 360;
        public int TimeScan { get; set; } = 5000;
        public int RetryScan { get; set; } = 5;
        public MailManager Mails { get; set; } = new MailManager();

        public RobotParams GetDefaultRobotParams()
        {
            return new RobotParams()
            {
                User = DefaultUser,
                Password = DefautlPassword,
                FolderBackup = DefaultFolderBackup,
                DelayDeleteFile = DefaultDelayDeleteFile,
                TimeoutBackup = DefaultTimeoutBackup,
            };
        }
        public RobotParams GetDefaultRobotParams(ControllerInfo controllerInfo)
        {


            return new RobotParams()
            {
                Id = controllerInfo.SystemId,
                IP = controllerInfo.IPAddress.ToString(),
                User = DefaultUser,
                Password = DefautlPassword,
                FolderBackup = DefaultFolderBackup,
                NameFileBackup = controllerInfo.Name,
                DelayDeleteFile = DefaultDelayDeleteFile,
                TimeoutBackup = DefaultTimeoutBackup,
            };
        }

        public new bool Add(RobotParams robot)
        {

            if (this.Any(r => r.Id == robot.Id))
            {
                return false;
            }
            base.Add(robot);

            return true;
        }

        public XElement ToXmlElement()
        {
            XElement xmlRoot = new XElement("BackupList");
            XElement xElementUser = new XElement(nameof(DefaultUser), DefaultUser);
            XElement xElementPassword = new XElement(nameof(DefautlPassword), DefautlPassword);
            XElement xElementFolder = new XElement(nameof(DefaultFolderBackup), DefaultFolderBackup);
            XElement xElementTimeOut = new XElement(nameof(DefaultTimeoutBackup), DefaultTimeoutBackup);
            XElement xElementDelayDeleteFile = new XElement(nameof(DefaultDelayDeleteFile), DefaultDelayDeleteFile);
            XElement xElementTimeScan = new XElement(nameof(TimeScan), TimeScan);
            XElement xElementRetryScan = new XElement(nameof(RetryScan), RetryScan);
            XElement xElementMail =  Mails.ToXmlElement();

            XElement xElementRobot = new XElement(nameof(RobotParamsList));

            foreach (RobotParams robot in this)
            {
                xElementRobot.Add(robot.ToXmlElement());
            }
            xmlRoot.Add(xElementUser);
            xmlRoot.Add(xElementPassword);
            xmlRoot.Add(xElementFolder);
            xmlRoot.Add(xElementTimeOut);
            xmlRoot.Add(xElementDelayDeleteFile);
            xmlRoot.Add(xElementTimeScan);
            xmlRoot.Add(xElementRetryScan);
            xmlRoot.Add(xElementMail);
            xmlRoot.Add(xElementRobot);



            return xmlRoot;
        }

        public static RobotParamsList FromXml(XElement xElement)
        {
            RobotParamsList p = new RobotParamsList();
            try
            {
                p.DefaultFolderBackup = xElement?.Element(nameof(DefaultFolderBackup))?.Value;
                p.DefaultTimeoutBackup = int.Parse(xElement?.Element(nameof(DefaultTimeoutBackup))?.Value);
                p.DefaultDelayDeleteFile = int.Parse(xElement?.Element(nameof(DefaultDelayDeleteFile))?.Value);
                p.DefaultUser = xElement?.Element(nameof(DefaultUser))?.Value;
                p.DefautlPassword = xElement?.Element(nameof(DefautlPassword))?.Value;
                p.TimeScan = int.Parse(xElement?.Element(nameof(TimeScan))?.Value);
                p.RetryScan = int.Parse(xElement?.Element(nameof(RetryScan))?.Value);
                p.Mails = xElement.Element(nameof(MailManager))!=null ? MailManager.FromXml(xElement.Element(nameof(MailManager))): new MailManager();


                xElement = xElement.Element(nameof(RobotParamsList));

                foreach (XElement xElementRobotParams in xElement.Elements())
                {

                    var r = RobotParams.FromXml(xElementRobotParams);

                    if (r != null)
                    {
                        if (r.FolderBackup == null) r.FolderBackup = p.DefaultFolderBackup;
                        if (r.User == null) r.User = p.DefaultUser;
                        if (r.Password == null) r.Password = p.DefautlPassword;

                        if (r.DelayDeleteFile == 0) r.DelayDeleteFile = p.DefaultTimeoutBackup;
                        if (r.DelayDeleteFile == 0) r.DelayDeleteFile = p.DefaultDelayDeleteFile;

                        p.Add(r);
                    }



                }
            }
            catch (Exception ex)
            {
                LogsManager.Add(EnumCategory.Error, "Xml RobotParamsList", ex.Message);
                return null;
            }

            return p;

        }

        public void SaveFromXml(string path)
        {
            XDocument xDocument = new XDocument(this.ToXmlElement());
            xDocument.Save(path);
        }

        public static RobotParamsList LoadToXml(string path)
        {
            XDocument xDocument = XDocument.Load(path);

            return FromXml(xDocument.Root);

        }

    }
}
