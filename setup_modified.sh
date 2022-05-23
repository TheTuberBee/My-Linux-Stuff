#!/bin/bash
# arch linux after install setup script
set -e

cd /home/frt/Desktop || true
cd /home/frt/Asztal || true
wget -O tlauncher.zip https://tlauncher.org/jar
unzip tlauncher.zip
cp -R tlauncher/. .
rm -R tlauncher.zip
rm -R tlauncher