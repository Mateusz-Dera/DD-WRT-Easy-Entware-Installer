#!/bin/sh

# DD-WRT DD-WRT Easy Entware-ng Installer
# Copyright © 2019 Mateusz Dera

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

echo -e "\e[92;1;48;5;239m ====================================== \e[0m"
echo -e "\e[92;1;48;5;240m |  DD-WRT EASY ENTWARE INSTALLER     | \e[0m"
echo -e "\e[92;1;48;5;241m |  \e[94;1;48;5;241mMateusz Dera  \e[92;1;48;5;241m                    | \e[0m"
echo -e "\e[92;1;48;5;240m | \e[94;1;48;5;240m Version:\e[92;1;48;5;240m 2.0.1                    | \e[0m"
echo -e "\e[92;1;48;5;239m ====================================== \e[0m"

echo

cd /jffs || exit 1

if ! [ -d "/jffs/opt" ]; then
   mkdir /jffs/opt || exit 1
fi

if ! [ -d "/jffs/etc" ]; then
   mkdir /jffs/etc || exit 1
fi

if ! [ -d "/jffs/etc/config" ]; then
   mkdir /jffs/etc/config || exit 1
fi

mount -o bind /jffs/opt /opt

if ! [ -x "$(command -v /opt/bin/opkg update)" ]; then
   echo -e "\e[92;1;48;5;239m ================================ \e[0m"
   echo -e "\e[92;1;48;5;240m |  SELECT ROUTER ARCHITECTURE  | \e[0m"
   echo -e "\e[92;1;48;5;242m | \e[94;1;48;5;242m 0\e[92;1;48;5;242m ARMv7                     | \e[0m"
   echo -e "\e[92;1;48;5;243m | \e[94;1;48;5;243m 1\e[92;1;48;5;243m MIPSEL                    | \e[0m"
   echo -e "\e[92;1;48;5;243m | \e[94;1;48;5;243m 2\e[92;1;48;5;243m MIPS                      | \e[0m"
   echo -e "\e[92;1;48;5;239m ================================ \e[0m\n"
   read -p $'Number (Default 0): ' arch

   case $arch in
   "1") link="http://bin.entware.net/mipselsf-k3.4/installer/generic.sh" ;;
   "2") link="http://bin.entware.net/mipssf-k3.4/installer/generic.sh" ;;
   *) link="http://bin.entware.net/armv7sf-k3.2/installer/generic.sh"
   esac
  
   wget $link || exit 1
   sh generic.sh || exit 1

fi

export PATH=$PATH:/opt/bin:/opt/sbin || exit 1
opkg update || exit 1

cd /jffs/etc/config || exit 1
[ -f ./automatic_opt_mount.startup ] && rm automatic_opt_mount.startup
[ -f ./automatic_opt_mount.startup ] && exit 1
echo -e '#!/bin/sh\n/usr/bin/logger -t START_$(basename $0) "started [$@]"\nSCRLOG=/tmp/$(basename $0).log\ntouch $SCRLOG\nTIME=$(date +"%Y-%m-%d %H:%M:%S")\necho $TIME "$(basename $0) script started [$@]" >> $SCRLOG\nmount -o bind /jffs/opt/ /opt/ \nTIME=$(date +"%Y-%m-%d %H:%M:%S")\nif [ "$?" -ne 0 ]\nthen\necho $TIME "Error in script execution! Script: $0" >> $SCRLOG\nelse\necho $TIME "Script execution OK. Script: $0" >> $SCRLOG\nfi\n/usr/bin/logger -t STOP_$(basename $0) "return code $?"\nexit $?' > automatic_opt_mount.startup || exit 1
[ -f ./automatic_opt_mount.startup ] || exit 1
chmod 700 automatic_opt_mount.startup || exit 1

case $1 in
   "-s") exit 0;;
   *) echo -e "Installation complete!\nRestart router"
esac
