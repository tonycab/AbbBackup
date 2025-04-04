using ABB.Robotics.Controllers;
using AbbBackup.Logs;
using AbbBackup.Report;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace AbbBackup.Params
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

            try { 

            p.Id = new Guid(xElement.Element(nameof(Guid))?.Value);
            p.IP = xElement.Element(nameof(IP))?.Value;
            p.User = xElement.Element(nameof(User))?.Value;
            p.Password = xElement.Element(nameof(Password))?.Value;
            p.FolderBackup = xElement.Element(nameof(FolderBackup))?.Value;
            p.NameFileBackup = xElement.Element(nameof(NameFileBackup))?.Value;
            p.TimeoutBackup = int.TryParse(xElement.Element(nameof(TimeoutBackup))?.Value, out int timeoutBackup) ? timeoutBackup : 0;
            p.DelayDeleteFile = int.TryParse(xElement.Element(nameof(DelayDeleteFile))?.Value, out int telayDeleteFile) ? telayDeleteFile : 0;

            }
            catch (Exception ex) 
            {
                LogsManager.Add(EnumCategory.Error, "Xml RobotParams", ex.Message);
               
                return null;
            }

            return p;

        }

        //Méthode pour obtenir le chemin par défaut
        public static string GetDefaultPath()
        {
            return Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + "\\Backup";
        }

    }
  
}
