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

Télécharger➡️ [SetupAbbRobot.exe]((https://github.com/tonycab/AbbBackup/releases/tag/v2.0.0.0))

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
  <DefaultFolderBackup>C:\Users\alecabellec\Documents\Backup</DefaultFolderBackup>
  <DefaultTimeoutBackup>300</DefaultTimeoutBackup>
  <DefaultDelayDeleteFile>360</DefaultDelayDeleteFile>
  <TimeScan>5000</TimeScan>
  <RobotParamsList>
    <RobotParams>
      <Guid>ae6789fc-300c-4260-940d-c52d85f05f7e</Guid>
      <IP>192.32.98.231</IP>
      <User>Default User</User>
      <Password>robotics</Password>
      <FolderBackup>C:\Users\alecabellec\Documents\Backup</FolderBackup>
      <NameFileBackup>6700-138008</NameFileBackup>
      <TimeoutBackup>300</TimeoutBackup>
      <DelayDeleteFile>360</DelayDeleteFile>
    </RobotParams>
	    <RobotParams>
      <Guid>ae6789fc-300c-4260-940d-c52d85f0llhg</Guid>
      <IP>192.32.98.232</IP>
      <User>Default User</User>
      <Password>robotics</Password>
      <FolderBackup>C:\Users\alecabellec\Documents\Backup</FolderBackup>
      <NameFileBackup>6700-138009</NameFileBackup>
      <TimeoutBackup>300</TimeoutBackup>
      <DelayDeleteFile>360</DelayDeleteFile>
    </RobotParams>
  </RobotParamsList>
</BackupList>
```
## 4 - EXEMPLES
### Exemple 1

Cet exemple sauvegarde les robots présents sur le réseau
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

### Exemple 4

Cet exemple sauvegarde tout les robots présents sur le réseau.
* cmd
  ```sh
  C:\>AbbBackup.exe --all
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
- [ ] Amélioration du code

## 6 - INFORMATIONS

> [!WARNING]
> PC SDK ABB utilise une liaison FTP pour télécharger le programme. 

<p align="right">(<a href="#readme-top">Back to top</a>)</p>

