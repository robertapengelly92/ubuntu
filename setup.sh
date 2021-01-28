#!/bin/sh

sudo su

sync; echo 3 > /proc/sys/vm/drop_caches

echo "vm.swappiness=10" >> /etc/sysctl.conf
sysctl -p

echo "unset HISTFILE" >> /etc/bash.bashrc

echo "QT_QPA_PLATFORMTHEME=gtk2" >> /etc/environment
echo "QT_STYLE_OVERRIDE=gtk2" >> /etc/environment

sed -i -e 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/g' /etc/default/grub
update-grub

apt -y purge gstreamer1.0-fluendo-mp3 snapd whoopsie whoopsie-preferences
apt -y install gnome-calculator gnome-characters gnome-logs gnome-system-monitor

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
apt -y install ttf-mscorefonts-installer || exit 1

apt -y install chrome-gnome-shell gnome-tweaks ubuntu-restricted-extras || exit 1
apt -y install binutils bison flex gcc gcc-multilib g++ make printer-driver-escpr nasm nautilus-wipe || exit 1

add-apt-repository -y ppa:linuxuprising/java
add-apt-repository -y ppa:dosemu2/ppa
echo debconf shared/accepted-oracle-license-v1-2 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | sudo debconf-set-selection
apt -y install oracle-java15-installer oracle-java15-set-default || exit 1

apt -y install dosbox dosemu2 gettext git imagemagick libncursesw5 qt5-style-plugins p7zip-full p7zip-rar pkg-config sqlite3 subversion texinfo webp xorriso || exit 1
apt -y install qemu qemu-block-extra qemu-kvm qemu-slof qemu-system qemu-user qemu-utils || exit 1
apt -y install bochs bochsbios bochs-x vgabios || exit 1
apt -y install clementine deluge devede gdebi-core ghex gimp gir1.2-gmenu-3.0 gnome-control-center gnome-menus isomaster k3b kdenlive libreoffice python3 python3-pip simplescreenrecorder usb-creator-gtk vlc || exit 1
#apt -y install bless gnome-shell-extensions

chmod 4711 /usr/bin/wodim
chmod 4711 /usr/bin/cdrdao
chmod 4711 /usr/bin/growisofs

apt -y install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

apt update
apt -y install brave-browser code

wget -P /tmp https://launchpad.net/~notepadqq-team/+archive/ubuntu/notepadqq/+build/14811374/+files/notepadqq-common_1.4.4-1~bionic1_all.deb
wget -P /tmp https://launchpad.net/~notepadqq-team/+archive/ubuntu/notepadqq/+build/14811374/+files/notepadqq-gtk_1.4.4-1~bionic1_all.deb
wget -P /tmp https://launchpad.net/~notepadqq-team/+archive/ubuntu/notepadqq/+build/14811374/+files/notepadqq_1.4.4-1~bionic1_amd64.deb

gdebi -n /tmp/notepadqq-common_1.4.4-1~bionic1_all.deb
gdebi -n /tmp/notepadqq_1.4.4-1~bionic1_amd64.deb
gdebi -n /tmp/notepadqq-gtk_1.4.4-1~bionic1_all.deb

wget -P /tmp https://raw.githubusercontent.com/robertapengelly92/hopper/main/Hopper%20Disassembler%20v4.7.1/Hopper-v4-4.7.1-Linux.deb
wget -P /tmp https://raw.githubusercontent.com/robertapengelly92/hopper/main/Hopper%20Disassembler%20v4.7.1/patch-hopper.py

gdebi -n /tmp/Hopper-v4-4.7.1-Linux.deb
python3 /tmp/patch-hopper.py /opt/hopper-v4/bin/Hopper

apt -y purge --autoremove
exit

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
