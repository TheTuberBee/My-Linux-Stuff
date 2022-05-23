#!/bin/bash
# arch linux after install setup script
set -e

cd /home/frt
mkdir -p Repositories
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