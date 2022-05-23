#!/bin/bash
# arch linux after install setup script
sudo -i
set -e

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

sudo usermod --shell /bin/zsh frt