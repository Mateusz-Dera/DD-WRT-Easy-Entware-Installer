## DD-WRT Easy Entware Installer

### Info:
  - This script install Optware-ng
  - Tested on Netgear R6400v2 (DD-WRT v3.0-r46772 std)

### USB Requirements:
 - USB with **ext4** partition named **Optware**
 - Mounted **/opt** partition (**sda1**)
 ![USB](https://github.com/Mateusz-Dera/DD-WRT-Easy-Entware-Installer/blob/master/usb.png?raw=true)


### Installation:
```sh
cd /opt
curl -kLO https://raw.githubusercontent.com/Mateusz-Dera/DD-WRT-Easy-Entware-Installer/master/install.sh
sh ./install.sh
reboot
```

### Test:
```sh
opkg update
opkg install nano
```
