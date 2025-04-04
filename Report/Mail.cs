using AbbBackup.Logs;
using AbbBackup.Params;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace AbbBackup.Report
{
    public class Mail
    {

        public string AdressMailTo { get; set; } = "ExempleTo@server.com";
        public string NameTo { get; set; } = "Name";
        public bool AllLogs {  get; set; } = false;
        public bool Actived { get; set; } = false;
        public XElement ToXmlElement(XElement xElement)
        {
 
            XElement AdressMailToElement = new XElement(nameof(AdressMailTo), AdressMailTo);
            XElement NameToElement = new XElement(nameof(NameTo), NameTo);
            XElement AllLogsToElement = new XElement(nameof(AllLogs), AllLogs);
            XElement ActivedElement = new XElement(nameof(Actived), Actived);

            XElement xElementRobot = new XElement(nameof(RobotParamsList));


            xElement.Add(AdressMailToElement);
            xElement.Add(NameToElement);
            xElement.Add(AllLogsToElement);
            xElement.Add(ActivedElement);
            return xElement;
        }

        public static Mail FromXml(XElement xElement)
        {
            Mail mail = new Mail();

            mail.AdressMailTo = xElement?.Element(nameof(AdressMailTo))?.Value;
            mail.NameTo = xElement?.Element(nameof(NameTo))?.Value;
            mail.AllLogs = bool.Parse(xElement?.Element(nameof(AllLogs)).Value);
            mail.Actived = bool.Parse(xElement?.Element(nameof(Actived)).Value);

            return mail;

        }


    }
}
