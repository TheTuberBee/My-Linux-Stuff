#!/bin/bash
# arch linux after install setup script

set -e

##################################################################################################################

# PROCESSZOR BEÁLLÍTÓ SCRIPT

##################################################################################################################

numberofcores=$(grep -c ^processor /proc/cpuinfo)

if [ $numberofcores -gt 1 ]
then
        echo "You have " $numberofcores" cores."
        echo "Changing the makeflags for "$numberofcores" cores."
        sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores+1))'"/g' /etc/makepkg.conf;
        echo "Changing the compression settings for "$numberofcores" cores."
        sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T '"$numberofcores"' -z -)/g' /etc/makepkg.conf
else
        echo "No change."
fi


echo "################################################################"
echo "###  All cores will be used during building and compression ####"
echo "################################################################"

############################################################
###		Archlinux program telepítő script	 ###
###		v2.0 (GTK/XFCE)				 ###
############################################################

sudo pacman -Syyu --noconfirm

# HANG DOLGOK TELEPÍTÉSE

sudo pacman -S pulseaudio --noconfirm --needed
sudo pacman -S pulseaudio-alsa --noconfirm --needed
sudo pacman -S pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
sudo pacman -S gstreamer --noconfirm --needed
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly --noconfirm --needed
sudo pacman -S volumeicon --noconfirm --needed
sudo pacman -S playerctl --noconfirm --needed

echo "################################################################"
echo "#########       Hangrendszer telepítve          ################"
echo "################################################################"

# BLUETOOTH (if needed)

sudo pacman -S --noconfirm --needed pulseaudio-bluetooth
sudo pacman -S --noconfirm --needed bluez
sudo pacman -S --noconfirm --needed bluez-libs
sudo pacman -S --noconfirm --needed bluez-utils
sudo pacman -S --noconfirm --needed blueberry

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

echo "reboot your system then ..."
echo "set with bluetooth icon in bottom right corner"
echo "change to have a2dp if needed"


echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"

# NETWORK DISCOVERY

sudo pacman -S --noconfirm --needed avahi
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service

sudo pacman -S --noconfirm --needed nss-mdns

sudo pacman -S --noconfirm --needed gvfs-smb

sudo sed -i 's/files mymachines myhostname/files mymachines/g' /etc/nsswitch.conf

sudo sed -i 's/\[\!UNAVAIL=return\] dns/\[\!UNAVAIL=return\] mdns dns wins myhostname/g' /etc/nsswitch.conf

echo "################################################################"
echo "####       network discovery  software installed        ########"
echo "################################################################"

# KIEGÉSZÍTŐ PROGRAMOK

sudo pacman -S --noconfirm --needed accountsservice
sudo pacman -S --noconfirm --needed baobab
sudo pacman -S --noconfirm --needed curl
sudo pacman -S --noconfirm --needed dconf-editor
sudo pacman -S --noconfirm --needed dmidecode
sudo pacman -S --noconfirm --needed ffmpegthumbnailer
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed gnome-disk-utility
sudo pacman -S --noconfirm --needed gnome-keyring
sudo pacman -S --noconfirm --needed gnome-system-monitor
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed grsync
sudo pacman -S --noconfirm --needed gtk-engine-murrine
sudo pacman -S --noconfirm --needed gvfs gvfs-mtp
sudo pacman -S --noconfirm --needed hddtemp
sudo pacman -S --noconfirm --needed htop
sudo pacman -S --noconfirm --needed lm_sensors
sudo pacman -S --noconfirm --needed lsb-release
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed net-tools
sudo pacman -S --noconfirm --needed polkit-gnome
sudo pacman -S --noconfirm --needed reflector
sudo pacman -S --noconfirm --needed qt5ct
sudo pacman -S --noconfirm --needed sane
sudo pacman -S --noconfirm --needed scrot
sudo pacman -S --noconfirm --needed sysstat
sudo pacman -S --noconfirm --needed tumbler
sudo pacman -S --noconfirm --needed vnstat
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed wmctrl
sudo pacman -S --noconfirm --needed unclutter
sudo pacman -S --noconfirm --needed xdg-user-dirs
sudo pacman -S --noconfirm --needed xdo
sudo pacman -S --noconfirm --needed xdotool
sudo pacman -S --noconfirm --needed zenity
sudo pacman -S --noconfirm --needed imagemagick
sudo pacman -S --noconfirm --needed w3m
sudo pacman -S --noconfirm --needed xfce4-notifyd

# TÖMÖRÍTŐK
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller

# BETŰTÍPUSOK

sudo pacman -S adobe-source-sans-pro-fonts --noconfirm --needed
sudo pacman -S cantarell-fonts --noconfirm --needed
sudo pacman -S noto-fonts --noconfirm --needed
sudo pacman -S ttf-bitstream-vera --noconfirm --needed
sudo pacman -S ttf-dejavu --noconfirm --needed
sudo pacman -S ttf-droid --noconfirm --needed
sudo pacman -S ttf-hack --noconfirm --needed
sudo pacman -S ttf-inconsolata --noconfirm --needed
sudo pacman -S ttf-liberation --noconfirm --needed
sudo pacman -S ttf-roboto --noconfirm --needed
sudo pacman -S ttf-ubuntu-font-family --noconfirm --needed
sudo pacman -S tamsyn-font --noconfirm --needed
sudo pacman -S noto-fonts-emoji --noconfirm --needed

# INTEL / AMD UCODE

sudo pacman -S intel-ucode --noconfirm
sudo grub-mkconfig -o /boot/grub/grub.cfg

# SZEMÉLYES PROGRAMOK

sudo pacman -S --noconfirm --needed audacity
sudo pacman -S --noconfirm --needed obs-studio
sudo pacman -S --noconfirm --needed guvcview
sudo pacman -S --noconfirm --needed kdenlive
sudo pacman -S --noconfirm --needed frei0r-plugins
sudo pacman -S --noconfirm --needed dvdauthor
sudo pacman -S --noconfirm --needed cdrtools
sudo pacman -S --noconfirm --needed catfish
sudo pacman -S --noconfirm --needed galculator
sudo pacman -S --noconfirm --needed gimp
sudo pacman -S --noconfirm --needed gnome-font-viewer
sudo pacman -S --noconfirm --needed gpick
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed evince
sudo pacman -S --noconfirm --needed libreoffice-fresh-hu
sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed python
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed htop
sudo pacman -S --noconfirm --needed gnome-tweaks
sudo pacman -S --noconfirm --needed kitty
sudo pacman -S --noconfirm --needed jdk11-openjdk

sudo pacman -S --noconfirm --needed yay

yay -S --noconfirm --needed neofetch
yay -S --noconfirm --needed spotify
yay -S --noconfirm --needed visual-studio-code-bin
yay -S --noconfirm --needed github-desktop-bin
yay -S --noconfirm --needed balena-etcher


cd /
sudo dd if=/dev/zero of=/swapfile count=4096 bs=1MiB
sudo chmod 600 swapfile
sudo mkswap swapfile
sudo swapon swapfile

echo "/swapfile none swap defaults 0 0" >> /etc/fstab
echo "vm.swappiness=20" >> /etc/sysctl.d/99-sysctl.conf

cd /home/frt
mkdir Repositories
cd Repositories
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd /home/frt/Desktop
cd /home/frt/Asztal
wget -O tlauncher.zip https://tlauncher.org/jar
unzip tlauncher.zip
cp -R tlauncher/. .
rm -R tlauncher.zip
rm -R tlauncher
