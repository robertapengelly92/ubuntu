#!/bin/bash

read -sp "Please enter your password: " password

#echo $password | sudo -S su || exit

echo $password | sudo -S bash -c "sync; echo 3 > /proc/sys/vm/drop_caches"

echo $password | sudo -S bash -c "echo vm.swappiness=10 >> /etc/sysctl.conf"
echo $password | sudo -S sysctl -p

echo $password | sudo -S bash -c "echo unset HISTFILE >> /etc/bash.bashrc"

echo $password | sudo -S bash -c "echo QT_QPA_PLATFORMTHEME=gtk2 >> /etc/environment"
echo $password | sudo -S bash -c "echo QT_STYLE_OVERRIDE=gtk2 >> /etc/environment"

echo $password | sudo -S bash -c "sed -i -e 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub"
echo $password | sudo -S update-grub

echo debconf shared/accepted-oracle-license-v1-2 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | sudo debconf-set-selection
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

exit 1

echo $password | sudo -S apt -y install ttf-mscorefonts-installer || exit 1

echo $password | sudo -S apt -y install chrome-gnome-shell gnome-tweaks ubuntu-restricted-extras || exit 1
echo $password | sudo -S apt -y install binutils bison flex gcc gcc-multilib g++ make nasm nautilus-wipe || exit 1

echo $password | sudo -S add-apt-repository -y ppa:linuxuprising/java
echo $password | sudo -S apt -y install oracle-java14-installer oracle-java14-set-default || exit 1

echo $password | sudo -S apt -y install git imagemagick libncursesw5 qt5-style-plugins p7zip-full p7zip-rar pkg-config sqlite3 webp || exit 1
echo $password | sudo -S apt -y install qemu qemu-block-extra qemu-slof qemu-system qemu-user qemu-utils || exit 1
echo $password | sudo -S apt -y install bochs bochsbios bochs-x vgabios || exit 1
echo $password | sudo -S apt -y install clementine deluge gdebi-core ghex gimp gnome-control-center isomaster k3b kdenlive libreoffice python3-pip simplescreenrecorder vlc || exit 1

echo $password | sudo -S chmod 4711 /usr/bin/wodim
echo $password | sudo -S chmod 4711 /usr/bin/cdrdao

echo $password | sudo -S apt -y purge --autoremove
echo $password | sudo -S adduser $USER kvm

mkdir -p ~/.config ~/.fonts ~/.vmware
mkdir -p ~/.config/Code/User ~/.config/Notepadqq

wget -O ~/.config/Code/User/keybindings.json https://raw.githubusercontent.com/robertapengelly92/visual-studio-code/master/keybindings.json
wget -O ~/.config/Code/User/settings.json https://raw.githubusercontent.com/robertapengelly92/visual-studio-code/master/settings.json
wget -O ~/.config/Notepadqq/Notepadqq.ini https://raw.githubusercontent.com/robertapengelly92/ubuntu/master/Notepadqq.ini
wget -O ~/.vmware/preferences https://raw.githubusercontent.com/robertapengelly92/ubuntu/master/preferences
wget -qO- http://plasmasturm.org/code/vistafonts-installer/vistafonts-installer | bash

echo "[QT]" >> ~/.config/Trolltech.conf
echo "style=GTK+" >> ~/.config/Trolltech.conf

gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set com.ubuntu.update-notifier show-livepatch-status-icon false