#!/bin/sh

#CURUSER=$USER;

sudo su
sync; echo 3 > /proc/sys/vm/drop_caches

echo "vm.swappiness=10" >> /etc/sysctl.conf
sysctl -p

echo "unset HISTFILE" >> /etc/bash.bashrc

echo "QT_QPA_PLATFORMTHEME=gtk2" >> /etc/environment
echo "QT_STYLE_OVERRIDE=gtk2" >> /etc/environment

#wget -O /etc/default/grub https://raw.githubusercontent.com/robertapengelly92/Ubuntu/master/grub
sed -i -e 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub
update-grub

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
wget -O /var/cache/apt/archives/ttf-mscorefonts-installer_3.7_all.deb http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb
dpkg -i /var/cache/apt/archives/ttf-mscorefonts-installer_3.7_all.deb

apt -y purge gstreamer1.0-fluendo-mp3 snapd whoopsie whoopsie-preferences
apt -y install gnome-calculator gnome-characters gnome-logs gnome-system-monitor
apt -y install chrome-gnome-shell gnome-tweaks ubuntu-restricted-extras
apt -y install binutils bison flex gcc gcc-multilib make nasm nautilus-wipe

#add-apt-repository -y ppa:fossproject/ppa
add-apt-repository -y ppa:linuxuprising/java
#add-apt-repository -y ppa:notepadqq-team/notepadqq

echo debconf shared/accepted-oracle-license-v1-2 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | sudo debconf-set-selections

#apt -y install green-recorder notepadqq oracle-java14-installer
apt -yd install oracle-java14-installer

mkdir -p /tmp/oracle-java14-installer/DEBIAN
dpkg-deb -x /var/cache/apt/archives/oracle-java14-installer_14.0-1~linuxuprising1_amd64.deb /tmp/oracle-java14-installer
dpkg-deb -e /var/cache/apt/archives/oracle-java14-installer_14.0-1~linuxuprising1_amd64.deb /tmp/oracle-java14-installer/DEBIAN

wget -O /tmp/oracle-java14-installer/DEBIAN/config https://raw.githubusercontent.com/robertapengelly92/ubuntu/master/oracle-java14-installer.config
wget -O /tmp/oracle-java14-installer/DEBIAN/postinst https://raw.githubusercontent.com/robertapengelly92/ubuntu/master/oracle-java14-installer.postinst

dpkg-deb -b /tmp/oracle-java14-installer /var/cache/apt/archives
dpkg -i /var/cache/apt/archives/oracle-java14-installer_14.0-1~linuxuprising1_amd64.deb

apt -y install oracle-java14-set-default
apt -y install git imagemagick libncursesw5 qt5-style-plugins p7zip-full p7zip-rar pkg-config sqlite3 webp
apt -y install qemu qemu-block-extra qemu-slof qemu-system qemu-user qemu-utils
apt -y install bochs bochs-x clementine deluge gdebi-core ghex gimp gnome-control-center isomaster k3b kdenlive libreoffice python3-pip simplescreenrecorder vlc

#adduser $CURUSER kvm
chmod 4711 /usr/bin/wodim; sudo chmod 4711 /usr/bin/cdrdao

apt -y purge --autoremove

exit # exit su shell

mkdir -p ~/.config ~/.fonts ~/.vmware
mkdir -p ~/.config/Code/User

wget -O ~/.config/Code/User/keybindings.json https://raw.githubusercontent.com/robertapengelly92/visual-studio-code/master/keybindings.json
wget -O ~/.config/Code/User/settings.json https://raw.githubusercontent.com/robertapengelly92/visual-studio-code/master/settings.json
wget -O ~/.vmware/preferences https://raw.githubusercontent.com/robertapengelly92/ubuntu/master/preferences
wget -qO- http://plasmasturm.org/code/vistafonts-installer/vistafonts-installer | bash

echo "[QT]" >> ~/.config/Trolltech.conf
echo "style=GTK+" >> ~/.config/Trolltech.conf

#gsettings set org.gnome.shell enable-hot-corners true
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set com.ubuntu.update-notifier show-livepatch-status-icon false

#history -c && reboot
