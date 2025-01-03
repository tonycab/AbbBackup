<a id="readme-top"></a>
# Abb Backup

<!-- LOGO -->
<div align="center">
  <a href="https://github.com/tonycab/AbbBackup">
    <img src="Logo.png" alt="Logo" width="120" height="120">
  </a>
</div>

## LE PROJET

AbbBackup est une application Windows pour réaliser la sauvegarde des robots IRC5 ABB.
L'application permet de sauvegarder les robots présents sur le réseau. Très pratique lorsque vos installations
comportent de nombreux robots.

😊 Pensez à utiliser le planificateur de taches windows pour sauvegarder vos robots prériodiquement.


> [!NOTE]
> L'application utilise PC SDK ABB ➡️ https://developercenter.robotstudio.com/

> [!WARNING]
> Uniquement les robots réels sont sauvegardés. Les robots virtuels sont ignorés

<!-- COMMENCER --> 

## 1 - TELECHARGER

Télecharger et installer PC SDK ABB ➡️ [PC SDK ABB](https://developercenter.robotstudio.com/pc-sdk/download)


Télecharger➡️ [AbbRobot.exe](https://github.com/tonycab/AbbBackup/releases/download/v1.1.0.0/AbbBackup.exe)

## 2 - COMMENCER

Exécuter l'application

***ou***

Ouvrir l'invite de commande Windows et se placer dans le répertoire contenant l'exécutable "AbbBackup.exe" 

## 3 - EXEMPLES
### EXEMPLE 1

Cet exemple sauvegarde les robots présents sur le réseau 
* cmd
  ```sh
  C:\>AbbBackup.exe
  ```

### EXEMPLE 2

Cet exemple sauvegarde les robots présents sur le réseau dans un répertoire "Backup" placé sur le bureau Windows. Les sauvegardes de plus de 365 jours sont supprimées
* cmd
  ```sh
  C:\>AbbBackup.exe --folder "%UserProfile%\Desktop" --delete 365 --timeout 180
  ```
### EXEMPLE 3

Cet exemple permet d'ajouter un fichier contenant les identifiants de connexion UAS 
* cmd
  ```sh
  C:\>AbbBackup.exe --folder "%UserProfile%\Desktop" --delete 365 --timeout 180 --list "fileRobot.xml"
  ```

* fileRobot.xml
  ```xml
  <?xml version="1.0" encoding="utf-8"?>
     <BackupList>
  	<RobotList>
    	   <Robot>
     	      <Guid>34fbabb1-ac2e-4336-a740-94dc73ab760d</Guid>
     	      <User>Default User</User>
    	      <Password>robotics</Password>
    	   </Robot>
  	</RobotList>
     </BackupList>
  ```
  
> [!CAUTION]
> Le mot de passe n'est pas crypté.


## Amélioration à faire

- [x] Suppression des sauvegardes anciennes
- [x] Ajout de la gestion de connexion
- [x] Zip des sauvegardes
- [ ] Sauvegarde uniquement des robots contenu dans une liste

## INFORMATION
> [!CAUTION]
> PC SDK ABB utilise une liaison FTP pour télécharger le programme. 

## Contact

a.lecabellec@siif.fr

<p align="right">(<a href="#readme-top">Back to top</a>)</p>

