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


        public XElement ToXmlElement()
        {
            XElement xElement = new XElement(nameof(RobotParams));
            xElement.SetElementValue(nameof(Guid), Id);
            xElement.SetElementValue(nameof(IP), IP);
            xElement.SetElementValue(nameof(User), User);
            xElement.SetElementValue(nameof(Password), Password);
            xElement.SetElementValue(nameof(FolderBackup), FolderBackup);
            xElement.SetElementValue(nameof(NameFileBackup), NameFileBackup);
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

            return p;

        }

        //Méthode pour obtenir le chemin par défaut
        public static string GetDefaultPath()
        {
            return Environment.GetFolderPath(Environment.SpecialFolder.Desktop) + "\\Backup";
        }

    }
    public class RobotParamsList : List<RobotParams>
    {

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
            XElement xElement = new XElement(nameof(RobotParamsList));

            foreach (RobotParams robot in this)
            {
                xElement.Add(robot.ToXmlElement());
            }
            return xElement;
        }

        public static RobotParamsList FromXml(XElement xElement)
        {
            RobotParamsList p = new RobotParamsList();

            xElement = xElement.Element(nameof(RobotParamsList));

            foreach(XElement xElement1 in xElement.Elements())
            {
                p.Add(RobotParams.FromXml(xElement));
            }

            return p;

        }



        public void SaveFromXml(string path)
        {
            XElement xmlRoot = new XElement("BackupList");
            XDocument xDocument = new XDocument(xmlRoot);

            xmlRoot.Add(this.ToXmlElement());

            xDocument.Save(path);

        }

        public static RobotParamsList LoadToXml(string path)
        {
            XDocument xDocument = XDocument.Load(path);

            return FromXml(xDocument.Root);

        }

    }
}
