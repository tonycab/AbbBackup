using ABB.Robotics.Controllers;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace AbbBackup
{

    public class RobotParams
    {
        public Guid Id { get; set; } //Identification unique du robot
        public string IP { get; set; } //Adresse IP du robot
        public string User { get; set; } = "Default User"; //Nom d'utilisateur
        public string Password { get; set; } = "robotics"; //Mot de passe
        public string FolderBackup { get; set; } = GetDefaultPath(); //Dossier de sauvegarde
        public string NameFileBackup { get; set; } //Nom du fichier de sauvegarde
        public int  TimeoutBackup { get; set; }
        public int DelayDeleteFile { get; set; }


        public XElement ToXmlElement()
        {
            XElement xElement = new XElement(nameof(RobotParams));
            xElement.SetElementValue(nameof(Guid), Id);
            xElement.SetElementValue(nameof(IP), IP);
            xElement.SetElementValue(nameof(User), User);
            xElement.SetElementValue(nameof(Password), Password);
            xElement.SetElementValue(nameof(FolderBackup), FolderBackup);
            xElement.SetElementValue(nameof(NameFileBackup), NameFileBackup);
            xElement.SetElementValue(nameof(TimeoutBackup), TimeoutBackup);
            xElement.SetElementValue(nameof(DelayDeleteFile), DelayDeleteFile);
            return xElement;
        }

        public static RobotParams FromXml(XElement xElement)
        {
            RobotParams p = new RobotParams();

            xElement = xElement.Element(nameof(RobotParams));
            p.Id = new Guid(xElement.Element(nameof(Guid))?.Value);
            p.IP = xElement.Element(nameof(IP))?.Value;
            p.User = xElement.Element(nameof(User))?.Value;
            p.Password = xElement.Element(nameof(Password))?.Value;
            p.FolderBackup = xElement.Element(nameof(FolderBackup))?.Value;
            p.NameFileBackup = xElement.Element(nameof(NameFileBackup))?.Value;
            p.TimeoutBackup = int.Parse(xElement.Element(nameof(TimeoutBackup))?.Value);
            p.DelayDeleteFile = int.Parse(xElement.Element(nameof(DelayDeleteFile))?.Value);
            return p;

        }

        //Méthode pour obtenir le chemin par défaut
        public static string GetDefaultPath()
        {
            return Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
        }

    }
    public class RobotParamsList : List<RobotParams>
    {
        public string DefaultUser { get; set; } = "Default User";
        public string DefautlPassword { get; set; } = "robotics";
        public string DefaultFolderBackup { get; set; } = RobotParams.GetDefaultPath();
        public int DefaultTimeoutBackup { get; set; } = 300;
        public int DefaultDelayDeleteFile { get; set; } = 360;

        public RobotParams GetDefaultRobotParams()
        {
            return new RobotParams() { 
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

        public new void Add(RobotParams robot)
        {
            if (this.Any(r => r.Id == robot.Id))
            {
                return;
            }
            base.Add(robot);
        }

        public XElement ToXmlElement()
        {
            XElement xmlRoot = new XElement("BackupList");
            XElement xElementUser = new XElement(nameof(DefaultUser), DefaultUser);
            XElement xElementPassword = new XElement(nameof(DefautlPassword), DefautlPassword);
            XElement xElementFolder = new XElement(nameof(DefaultFolderBackup), DefaultFolderBackup);
            XElement xElementTimeOut = new XElement(nameof(DefaultTimeoutBackup), DefaultTimeoutBackup);
            XElement xElementDelayDeleteFile = new XElement(nameof(DefaultDelayDeleteFile), DefaultDelayDeleteFile);

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
            xmlRoot.Add(xElementRobot);
           

            return xmlRoot;
        }

        public static RobotParamsList FromXml(XElement xElement)
        {
            RobotParamsList p = new RobotParamsList();

            p.DefaultFolderBackup = xElement.Element(nameof(DefaultFolderBackup))?.Value;
            p.DefaultTimeoutBackup = int.Parse(xElement.Element(nameof(DefaultTimeoutBackup))?.Value);
            p.DefaultDelayDeleteFile = int.Parse(xElement.Element(nameof(DefaultDelayDeleteFile))?.Value);

            xElement = xElement.Element(nameof(RobotParamsList));

            foreach(XElement xElement1 in xElement.Elements())
            {
                p.Add(RobotParams.FromXml(xElement));
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
