#!/bin/sh

sudo su
sync; echo 3 > /proc/sys/vm/drop_caches

echo vm.swappiness=10 > /etc/sysctl.conf
sysctl -p

echo "unset HISTFILE" > /etc/bash.bashrc

echo QT_QPA_PLATFORMTHEME=gtk2 > /etc/environment
echo QT_STYLE_OVERRIDE > /etc/environment

wget https://raw.githubusercontent.com/robertapengelly92/Ubuntu/master/grub > /etc/default/grub
update-grub

apt purge -y gstreamer1.0-fluendo-mp3 snapd whoopsie whoopsie-preferences
apt install -y gnome-calculator gnome-characters gnome-logs gnome-system-monitor
apt install -y chrome-gnome-shell gnome-tweaks ubuntu-restricted-extras
apt install -y binutils bison flex gcc gcc-multilib make nasm nautilus-wip

#add-apt-repository -y ppa:fossproject/ppa
add-adt-repository -y ppa:linuxuprising/java
add-apt-repository -y ppa:notepadqq-team/notepadqq

apt install -y green-recorder notepadqq oracle-java14-installer
apt install -y git imagemagick libncursesw5 qt5-style-plugins p7zip-full p7zip-rar pkg-config sqlite3 webp
apt install -y qemu qemu-block-extra qemu-slof qemu-system qemu-user qemu-utils
apt install -y clementine deluge gdebi-core ghex gimp gnome-control-center isomaster k3b kdenlive libreoffice python-pip python3-pip simplescreenrecorder vlc

adduser $USER kvm
chmod 4711 /usr/bin/wodim; sudo chmod 4711 /usr/bin/cdrdao
wget -qO- http://plasmasturm.org/code/vistafonts-installer/vistafonts-installer | bash

exit # exit su shell

mkdir -p ~/.vmware ~/.config
wget https://raw.githubusercontent.com/robertapengelly92/Ubuntu/master/preferences > ~/.vmware/preferences
echo [QT] > ~/.config/Trolltech.conf
echo style=GTK+ > ~/.config/Trolltech.conf

gsettings set org.gnome.shell enable-hot-corners true
gsettings set org.gnome.shell.extensions.hash-to-dock click-action 'minimize'
gsettings set com.ubuntu.update-notifier show-livepatch-status-icon false

history -c && reboot
