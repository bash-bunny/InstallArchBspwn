#!/usr/bin

echo "Folders and files configuration"

echo "Creating Directories..."

if [ ! -d "~/.config" ] 
then
    mkdir -p ~/.config
fi

echo "Copying Files to HOME ..."

cp .bashrc ~/.
cp .conkyrc ~/.
cp .tmux.conf ~/.
cp -r .vim/ ~/.
cp .Xresources ~/.

echo "Copying config files to .config folder..."

cp -r .config/bspwm ~/.config/
cp -r .config/conky ~/.config/
cp -r .config/polybar ~/.config/
cp -r .config/Thunar ~/.config/
cp -r .config/variety ~/.config/

echo "Copying wallpapers"

cp -r backgrounds/ /usr/share/
