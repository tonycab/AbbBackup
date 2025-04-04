using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Security;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using System.Xml.Linq;
using System.IO;
using AbbBackup.Params;
using AbbBackup.Logs;

namespace AbbBackup.Report
{
    public class MailReport : IReport
    {
        public Mail Mail { get; set; }

        public string AdressMailFrom { get; set; }
        public string NameFrom { get; set; }
        public string CredentialName { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }

        public string HostSmtp { get; set; }
        public int PortSmtp { get; set; }
        public string[] Attach { get; set; }


        public MailReport()
        {

        }



        public bool Send()
        {
            try
            {
                var fromAddress = new MailAddress(AdressMailFrom, NameFrom);
                var toAddress = new MailAddress(Mail.AdressMailTo, Mail.NameTo);
                var identification = CredentialManager.GetCredential(CredentialName);

                var smtp = new SmtpClient
                {
                    Host = HostSmtp,
                    Port = PortSmtp,
                };

                //Ajout identification
                if (CredentialName != "")
                {
                    smtp.EnableSsl = true;

                    smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new NetworkCredential(identification.Item1, identification.Item2);
                }

                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = Subject,
                    Body = Content,
                    IsBodyHtml = true,
                })
                {
                    if (Attach != null)
                    {
                        foreach (var pathAttach in Attach)
                        {
                            message.Attachments.Add(new Attachment(pathAttach));
                        }
                    }
                    smtp.Send(message);
                }

                return true;

            }
            catch (Exception ex)
            {
                LogsManager.Add(EnumCategory.Error, "mail", ex.Message);
                return false;
            }


        }




        public class CredentialManager
        {
            [DllImport("Advapi32.dll", SetLastError = true, CharSet = CharSet.Auto)]
            private static extern bool CredRead(string target, CredentialType type, int reservedFlag, out IntPtr credentialPtr);

            [DllImport("Advapi32.dll", SetLastError = true)]
            private static extern void CredFree(IntPtr cred);

            private enum CredentialType : uint
            {
                Generic = 1,
                DomainPassword,
                DomainCertificate,
                DomainVisiblePassword,
                GenericCertificate,
                DomainExtended
            }

            [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
            private struct CREDENTIAL
            {
                public uint Flags;
                public CredentialType Type;
                public IntPtr TargetName;
                public IntPtr Comment;
                public System.Runtime.InteropServices.ComTypes.FILETIME LastWritten;
                public uint CredentialBlobSize;
                public IntPtr CredentialBlob;
                public uint Persist;
                public uint AttributeCount;
                public IntPtr Attributes;
                public IntPtr TargetAlias;
                public IntPtr UserName;
            }

            public static Tuple<string, string> GetCredential(string target)
            {
                try
                {

                    if (CredRead(target, CredentialType.Generic, 0, out IntPtr credentialPtr))
                    {
                        try
                        {
                            var credential = (CREDENTIAL)Marshal.PtrToStructure(credentialPtr, typeof(CREDENTIAL));
                            var userName = Marshal.PtrToStringUni(credential.UserName);
                            var password = Marshal.PtrToStringUni(credential.CredentialBlob, (int)credential.CredentialBlobSize / 2);
                            return new Tuple<string, string>(userName, password);
                        }
                        finally
                        {
                            CredFree(credentialPtr);
                        }
                    }
                    else
                    {
                        throw new Exception("Unable to retrieve the credential.");
                    }
                }

                catch (Exception ex)
                {
                    LogsManager.Add(EnumCategory.Error, "Crendential", ex.Message);
                    return null;

                }



            }
        }
    }
}
