#!/bin/bash

echo "Folders and files configuration"

echo "Creating Directories..."

user=$(whoami)

if [ ! -d "~/.config" ] 
then
    mkdir -p ~/.config
fi

if [ ! -d "~/.vim" ]
then
    mkdir -p ~/.vim
    mkdir -p ~/.vim/undodir
    mkdir -p ~/.vim/swp
    mkdir -p ~/.vim/bundle
fi

if [ ! -d "/etc/pacman.d/hooks" ]
then
    sudo mkdir -p /etc/pacman.d/hooks
fi

echo "Copying Files to HOME ..."

cp .bashrc ~/.
cp .conkyrc ~/.
cp .tmux.conf ~/.
cp vim/vimrc ~/.vim
cp .Xresources ~/.
cp .xinitrc ~/.
cp .Xdefaults ~/.

echo "Copying config files to .config folder..."

cp -r config/bspwm ~/.config/
cp -r config/polybar ~/.config/
cp -r config/Thunar ~/.config/
cp -r config/variety ~/.config/

echo "Copying wallpapers"

cp -r backgrounds/ ~/Pictures/

echo "Setting permissions..."

cd ~/.config/bspwm/
chmod +x bspwmrc autostart.sh
cd ~/.config/polybar
chmod +x launch.sh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sleep 1

echo "Setting /etc & /usr config files"
cd ~/InstallArch/InstallBswpm/
sudo cp oblogout.conf /etc/
sudo cp -r solarized-squares64/ /user/share/themes

sleep 1

echo "Setting some configuration..."
sudo updatedb # Update mlocate db
sudo localectl set-x11-keymap es # Set the keyboard map
# Config pacman
sudo cp mirrorupgrade.hook /etc/pacman.d/hooks/
sudo cp pacman.conf /etc/

sudo su -
ln -sf /home/$user/.vim .vim/
ln -sf /home/$user/.tmux.conf .tmux.conf
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf # Disable fucking beep sound
