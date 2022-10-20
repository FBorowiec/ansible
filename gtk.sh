#!/bin/bash

# Beautify logs
CHECK_MARK="\033[0;32m\u2713"

echo -e "Downloading gnome themes..."
wget -q https://github.com/daniruiz/flat-remix-gnome/archive/master.zip -O "$HOME"/Downloads/flat-remix-gnome-master.zip #gnome
echo -e "Downloading gtk themes..."
wget -q https://github.com/daniruiz/flat-remix-gtk/archive/master.zip -O "$HOME"/Downloads/flat-remix-gtk-master.zip #gtk
echo -e "Downloading icons themes..."
wget -q https://github.com/daniruiz/flat-remix/archive/master.zip -O "$HOME"/Downloads/flat-remix-master.zip #icons

echo -e "Unzipping themes..."
unzip -qq "$HOME"/Downloads/flat-remix-gnome-master.zip -d "$HOME"/Downloads
unzip -qq "$HOME"/Downloads/flat-remix-gtk-master.zip -d "$HOME"/Downloads
unzip -qq "$HOME"/Downloads/flat-remix-master.zip -d "$HOME"/Downloads

echo -e "Removing existing configuration..."
if [ -f " ${HOME}/.icons" ]; then
	rm -rf "$HOME"/.icons/*
else
	mkdir "$HOME"/.icons
fi

if [ -f "${HOME}/.themes" ]; then
	rm -rf "$HOME"/.themes/*
else
	mkdir "$HOME"/.themes
fi

echo -e "Moving themes..."
mv "$HOME"/Downloads/flat-remix-gnome-master/Flat-Remix-* "$HOME"/.themes
mv "$HOME"/Downloads/flat-remix-gtk-master/Flat-Remix-* "$HOME"/.themes
mv "$HOME"/Downloads/flat-remix-master/Flat-Remix-* "$HOME"/.icons
#sudo rm -rf ${HOME}/Downloads/flat*
gsettings set org.gnome.desktop.interface cursor-theme "DMZ-Black"

gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-Red-Dark-fullPanel"
gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Red-Dark-Solid"
gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Red-Dark"

# Exit on success
echo -e "$CHECK_MARK \e[1mScript execution succeeded!\e[0m\e[32m\e[39m"
