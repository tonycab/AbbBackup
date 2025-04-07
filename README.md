<a id="readme-top"></a>

# AbbBackup

<!-- LOGO -->
<!--
<div align="center">
  <a href="https://github.com/tonycab/AbbBackup">
    <img src="Logo.png" alt="Logo" width="120" height="120">
  </a>
</div>
-->

AbbBackup est une application Windows pour réaliser la sauvegarde des robots IRC5 ABB.
L'application permet de sauvegarder les robots présents sur le réseau. Très pratique lorsque vos installations
comportent de nombreux robots.

😊 Pensez à utiliser le planificateur de taches windows pour sauvegarder vos robots prériodiquement.

> [!NOTE]
> L'application utilise PC SDK ABB ➡️ https://developercenter.robotstudio.com/

> [!WARNING]
> Uniquement les robots réels sont sauvegardés. Les robots virtuels sont ignorés


## 1 - TELECHARGER

Télécharger et installer la dépendance PC SDK ABB ➡️ [PC SDK ABB](https://developercenter.robotstudio.com/pc-sdk/download)

Télécharger➡️ [SetupAbbRobot.exe](https://github.com/tonycab/AbbBackup/releases/download/v2.0.0.2/Setup.AbbBackup.2.0.0.2.exe)

## 2 - COMMENCER

Exécuter l'application

***ou***

Ouvrir l'invite de commande Windows et se placer dans le répertoire contenant l'exécutable "AbbBackup.exe" 

## 3 - FICHIER DE CONFIGURATION

Un fichier de configuration est automatique créé dans le répertoire "C:\Users\%UserProfile%\AppData\Local" ***après la première exécution***

* conf.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<BackupList>
  <DefaultUser>Default User</DefaultUser>
  <DefautlPassword>robotics</DefautlPassword>
  <DefaultFolderBackup>C:\Users\%UserProfile%\Documents\Backup</DefaultFolderBackup>
  <DefaultTimeoutBackup>300</DefaultTimeoutBackup>
  <DefaultDelayDeleteFile>360</DefaultDelayDeleteFile>
  <TimeScan>5000</TimeScan>
  <RetryScan>5</RetryScan>
  <MailManager>
	  <AdressMailFrom>exemple@server.smtp.fr</AdressMailFrom>
	<NameFrom>Backup Auto depuis SMTP </NameFrom>
	  <CredentialName>CredentialName</CredentialName>
      <HostSmtp>server.smtp.fr</HostSmtp>
      <PortSmtp>587</PortSmtp>
<ListMail>  
  <Mail>
      <AdressMailTo>Destinataire1@exemple.fr</AdressMailTo>
      <NameTo>Name Example 1</NameTo>
	  <AllLogs>TRUE</AllLogs>
	  <Actived>TRUE</Actived>
  </Mail>
  <Mail>
      <AdressMailTo>Destinataire2@exemple.fr</AdressMailTo>
      <NameTo>Name Example 2</NameTo>
	  <AllLogs>FALSE</AllLogs>
	  <Actived>TRUE</Actived>
  </Mail>
  </ListMail>  
</MailManager>
  <RobotParamsList>
    <RobotParams>
      <Guid>31ecea35-32f9-48ee-af4d-1ef5812a938d</Guid>
      <IP>192.32.98.231</IP>
      <User>Default User</User>
      <Password>robotics</Password>
      <FolderBackup>C:\Users\%UserProfile%\Documents\Backup</FolderBackup>
      <NameFileBackup>6700-137118</NameFileBackup>
      <TimeoutBackup>300</TimeoutBackup>
      <DelayDeleteFile>360</DelayDeleteFile>
    </RobotParams>
  </RobotParamsList>
</BackupList>
```
## 4 - EXEMPLES
### Exemple 1

Cet exemple sauvegarde les robots présents sur le réseau et répertorié dans le fichier de configuration conf.xml 
* cmd
  ```sh
  C:\>AbbBackup.exe
  ```
 ### Exemple 2

Cet exemple recherche les robots présents sur le réseau et les ajoutes au fichier de configuration conf.xml 
* cmd
  ```sh
  C:\>AbbBackup.exe --addconf
  ```
### Exemple 3

Cet exemple recherche les robots présents sur le réseau et les ajoutes au fichier de configuration spécifié 
* cmd
  ```sh
  C:\>AbbBackup.exe --addconf "%UserProfile%\Desktop\conf.xml"
  ```
### Exemple 3

Cet exemple sauvegarde les robots présents sur le réseau en spécifiant un fichier de configuration spécifié
* cmd
  ```sh
  C:\>AbbBackup.exe --conf "%UserProfile%\Desktop\conf.xml"
  ```


> [!NOTE]
> Le Guid est indiqué dans la sauvegarde robot "BACKINFO/system.guid" utiliser "AbbBackup.exe --addconf" pour ajouter facilement un robot au fichier de configuration

> [!CAUTION]
> Le mot de passe n'est pas crypté.


## 5 - AMELIORATION A FAIRE

- [x] Suppression des sauvegardes trop anciennes
- [x] Ajout de la gestion de connexion
- [x] Zip des sauvegardes
- [x] Sauvegarde uniquement des robots contenu dans une liste
- [x] Envoi d'un rapport par mail
- [ ] Amélioration du code

## 6 - INFORMATIONS

> [!WARNING]
> PC SDK ABB utilise une liaison FTP pour télécharger le programme. 

<p align="right">(<a href="#readme-top">Back to top</a>)</p>

