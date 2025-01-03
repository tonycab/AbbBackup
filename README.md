# -- AbbBackup --

## A Propos du projet


AbbBackup est un application Windows en invite de commande pour r aliser la sauvegarde de robots IRC5 ABB.
L'application permet de sauvegarder plusieurs robots tr s rapidement. Il est possible d'ex cuter la 
sauvegarde p riodiquement en utilisant le planificateur de tache Windows.



<!-- COMMENCER -->

## COMMENCER

Ouvrir l'invite de commande Windows et se placer dans le r pertoire contenant l'ex cutable "AbbBackup.exe" 

### EXEMPLE 1

Cet exemple sauvegarde les robots pr sents sur le r seau dans un r pertoire "Backup" plac  sur le bureau Windows. Les sauvegardes de plus de 365 jours sont supprim es
* cmd
  ```sh
  C:\>AbbBackup.exe --folder "%UserProfile%\Desktop" --delete 365 --timeout 180
  ```

Cet exemple permet d'ajouter un fichier contenant les identifiants de connexion 
* cmd
  ```sh
  C:\>AbbBackup.exe --folder "%UserProfile%\Desktop" --delete 365 --timeout 180 --list "fileRobot.xml"
  ```

* xml
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




<!-- ROADMAP -->
## Roadmap

- [x] Suppression des sauvegardes anciennes
- [x] Ajout de la gestion de connexion
- [x] Zip des sauvegardes
- [ ] Sauvegarde uniquement des robots contenu dans une liste


<!-- CONTACT -->
## Contact

a.lecabellec@siif.fr

<p align="right">(<a href="#readme-top">Back to top</a>)</p>

