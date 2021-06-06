#!/bin/sh

# DD-WRT DD-WRT Easy Entware Installer
# Copyright © 2019-2021 Mateusz Dera

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

cd /opt

echo -e "\033[0;32mDD-WRT Easy Entware Installer"
echo -e "Copyright © 2019-2021 Mateusz Dera"
echo -e "\033[1;33m"
echo -e "Detected architecture:"
uname -m
echo -e "\033[0;32m"

if ! [ -x "$(command -v /opt/bin/opkg update)" ]; then
   echo -e "0 ARMv7"
   echo -e "1 MIPSEL"
   echo -e "2 MIPS"
   read -p $'Number (Default 0): ' arch
   echo -e "\033[0m"

   case $arch in
   "1") link="http://bin.entware.net/mipselsf-k3.4/installer/generic.sh" ;;
   "2") link="http://bin.entware.net/mipssf-k3.4/installer/generic.sh" ;;
   *) link="http://bin.entware.net/armv7sf-k3.2/installer/generic.sh"
   esac
  
   wget $link
   sh generic.sh

fi

opkg update