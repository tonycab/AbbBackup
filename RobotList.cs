using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace AbbBackup
{

    public class Robot
    {
        public Guid Id { get; set; }
        public string User {  get; set; }
        public string Password { get; set; }



        public XElement ToXmlElement()
        {
            XElement xElement = new XElement(nameof(Robot));
            xElement.SetElementValue(nameof(Guid), Id);
            xElement.SetElementValue(nameof(User), User);
            xElement.SetElementValue(nameof(Password), Password);
            return xElement;
        }

        public static Robot FromXml(XElement xElement)
        {
            Robot p = new Robot();

            xElement = xElement.Element(nameof(Robot));

            p.Id = new Guid(xElement.Element(nameof(Guid))?.Value);
            p.User = xElement.Element(nameof(User))?.Value;
            p.Password = xElement.Element(nameof(Password))?.Value;
           
            return p;

        }

    }
    public class RobotList : List<Robot>
    {

        public XElement ToXmlElement()
        {
            XElement xElement = new XElement(nameof(RobotList));

            foreach (Robot robot in this)
            {
                xElement.Add(robot.ToXmlElement());
            }
            return xElement;
        }

        public static RobotList FromXml(XElement xElement)
        {
            RobotList p = new RobotList();

            xElement = xElement.Element(nameof(RobotList));

            foreach(XElement xElement1 in xElement.Elements())
            {
                p.Add(Robot.FromXml(xElement));
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

        public static RobotList LoadToXml(string path)
        {
            XDocument xDocument = XDocument.Load(path);

            return FromXml(xDocument.Root);

        }

    }
}
