#!/bin/bash

echo "Folders and files configuration"

echo "Creating Directories..."

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

if [ ! -d "/usr/share/backgrounds" ]
then
    sudo mkdir -p /usr/share/backgrounds
fi

sudo -- sh -c 'cp -r backgrounds/* /usr/share/backgrounds/'

echo "Setting permissions..."

cd ~/.config/bspwm/
chmod +x bspwmrc autostart.sh
cd ~/.config/polybar
chmod +x launch.sh
cd ~/.config/polybar/scripts
chmod +x get_ip.sh vpn_status.sh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sleep 1

echo 'Setting /etc and /usr config files'
cd ~/InstallArch/InstallBswpm/
sudo cp oblogout.conf /etc/
sudo cp -r solarized-squares64/ /usr/share/themes/

sleep 1

echo "Installing go tools"
go get -u github.com/tomnomnom/assetfinder
go get -u github.com/tomnomnom/httprobe
go get github.com/tomnomnom/waybackurls
go get github.com/ffuf/ffuf
go get -u github.com/lc/gau

sleep 1

echo "Setting some configuration..."
sudo updatedb # Update mlocate db
sudo localectl set-x11-keymap es # Set the keyboard map
# Config pacman
sudo cp mirrorupgrade.hook /etc/pacman.d/hooks/
sudo cp pacman.conf /etc/
# Config lightdm
sudo cp lightdm-gtk-greeter.conf /etc/lightdm/

echo "Disabling beep sound"
sudo -- sh -c 'echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf'

echo "Configuring Nice Burpsuite"
sudo -- sh -c 'echo "_JAVA_AWT_WM_NONREPARENTING=1" > /etc/environment'

echo "To configure root files execute:"
echo "sudo -- sh -c 'ln -sf /home/user/.vim /root/.vim'"
echo "sudo -- sh -c 'ln -sf /home/user/.tmux.conf /root/.tmux.conf'" 

echo "Reboot, open vim and execute :PluginInstall"
