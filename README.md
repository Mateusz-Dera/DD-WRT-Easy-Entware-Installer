# DD-WRT Easy Entware-ng Installer

### Info
![version](https://img.shields.io/badge/version-2.0.1-yellow.svg)

  - This script install Entware-ng, create and mount /opt parttion in /jffs/opt and add mount to autostart
  - Tested on Netgear R6400v2 (DD-WRT v3.0-r41813 std)

### USB Requirements
 - Mounted JFFS partition
 - Optional SWAP partition

### Installation

 ```bash
cd /jffs    
curl -kLO https://raw.githubusercontent.com/Mateusz-Dera/DD-WRT-Easy-Entware-ng-Installer/master/install.sh 
sh ./install.sh
 ```
