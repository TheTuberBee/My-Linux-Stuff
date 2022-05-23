#!/bin/bash
# arch linux after install setup script
set -e

cd /home/frt/Desktop || true
cd /home/frt/Asztal || true
wget -O tlauncher.zip https://tlauncher.org/jar
unzip -d tlauncher tlauncher.zip
cp -R tlauncher/. . || true
rm -R tlauncher.zip || true
rm -R tlauncher || true