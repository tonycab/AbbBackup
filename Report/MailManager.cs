using AbbBackup.Params;
using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace AbbBackup.Report
{
    public class MailManager : List<Mail>
    {
        public string AdressMailFrom { get; set; } = "From@ServerMail.com";
        public string NameFrom { get; set; } = "From Name";
        public string CredentialName { get; set; } = "Credential";
        public string HostSmtp { get; set; } = "Host.smtp.com";
        public int PortSmtp { get; set; } = 587;

        public MailManager()
        {
          
        }

        public XElement ToXmlElement()
        {
            XElement xElement = new XElement(nameof(MailManager));

            XElement AdressMailFromElement = new XElement(nameof(AdressMailFrom), AdressMailFrom);
            XElement NameFromElement = new XElement(nameof(NameFrom), NameFrom);
            XElement CredentialNameElement = new XElement(nameof(CredentialName), CredentialName);
            XElement HostSmtpElement = new XElement(nameof(HostSmtp), HostSmtp);
            XElement PortSmtpElement = new XElement(nameof(PortSmtp), PortSmtp);

            XElement listMail = new XElement("ListMail");

            if (this.Count == 0)
            {
                this.Add(new Mail());
            }

            foreach (Mail mail in this)
            {
                listMail.Add(mail.ToXmlElement(new XElement(nameof(Mail))));
            }

            xElement.Add(AdressMailFromElement);
            xElement.Add(NameFromElement);
            xElement.Add(CredentialNameElement);
            xElement.Add(HostSmtpElement);
            xElement.Add(PortSmtpElement);
            xElement.Add(listMail);

            return xElement;
        }

        public static MailManager FromXml(XElement xElement)
        {
            MailManager mailManager = new MailManager();

            mailManager.AdressMailFrom = xElement?.Element(nameof(AdressMailFrom))?.Value;
            mailManager.NameFrom = xElement?.Element(nameof(NameFrom))?.Value;
            mailManager.CredentialName = xElement?.Element(nameof(CredentialName))?.Value;
            mailManager.HostSmtp = xElement?.Element(nameof(HostSmtp))?.Value;
            mailManager.PortSmtp = int.TryParse(xElement.Element(nameof(PortSmtp))?.Value, out int timeoutBackup) ? timeoutBackup : 0;

            var listMail = xElement.Element("ListMail");


            foreach (XElement xElementMail in listMail.Elements(nameof(Mail)))
            {

                var m = Mail.FromXml(xElementMail);

                mailManager.Add(m);
 
            }

            return mailManager;

        }

        public void SaveFromXml(string path)
        {
            XDocument xDocument = new XDocument(this.ToXmlElement());
            xDocument.Save(path);
        }

        public static MailManager LoadToXml(string path)
        {
            XDocument xDocument = XDocument.Load(path);

            return FromXml(xDocument.Root);

        }





    }

}
