#!/bin/bash

# Set the cores
echo "Setting the cores"

set -e

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

echo ""

# --------------------
# Display Manager
# --------------------

echo "Setting Display Manager"

sudo pacman -Syu --noconfirm --needed
sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings bspwm sxhkd --noconfirm --needed
sudo systemctl enable lightdm.service -f
sudo systemctl set-default graphical.target

echo ""

# -------------------
# Sound
# -------------------

echo "Setting Sound"

sudo pacman -S pulseaudio --noconfirm --needed
sudo pacman -S pulseaudio-alsa --noconfirm --needed
sudo pacman -S pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
sudo pacman -S gstreamer --noconfirm --needed
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly --noconfirm --needed
sudo pacman -S volumeicon --noconfirm --needed
sudo pacman -S playerctl --noconfirm --needed

echo ""

# -----------------
# Bluetooth
# -----------------

echo "Setting Bluetooth"

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

echo ""

# -----------------
# Printers
# -----------------

echo "Setting Printers"

sudo pacman -S --noconfirm --needed cups cups-pdf

#first try if you can print without foomatic
#sudo pacman -S foomatic-db-engine --noconfirm --needed
#sudo pacman -S foomatic-db foomatic-db-ppds foomatic-db-nonfree-ppds foomatic-db-gutenprint-ppds --noconfirm --needed
sudo pacman -S ghostscript gsfonts gutenprint --noconfirm --needed
sudo pacman -S gtk3-print-backends --noconfirm --needed
sudo pacman -S libcups --noconfirm --needed
sudo pacman -S hplip --noconfirm --needed
sudo pacman -S system-config-printer --noconfirm --needed

sudo systemctl enable org.cups.cupsd.service

echo "After rebooting it will work"

echo ""

# -----------------
# Network Discovery
# -----------------

echo "Setting Network Discovery"

sudo pacman -S --noconfirm --needed wget curl

sudo pacman -S --noconfirm --needed avahi
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service

#shares on a mac
sudo pacman -S --noconfirm --needed nss-mdns

#shares on a linux
sudo pacman -S --noconfirm --needed gvfs-smb

#first part
sudo sed -i 's/files mymachines myhostname/files mymachines/g' /etc/nsswitch.conf
#last part
sudo sed -i 's/\[\!UNAVAIL=return\] dns/\[\!UNAVAIL=return\] mdns dns wins myhostname/g' /etc/nsswitch.conf

echo ""

# --------------------
# Battery for Laptops
# --------------------

echo "Install tlp for battery life - laptops"

sudo pacman -S --noconfirm --needed tlp
sudo systemctl enable tlp.service
sudo systemctl start tlp.service

echo ""

# --------------------
# Basic Linux Stuff
# --------------------

# software from standard Arch Linux repositories
# Core, Extra, Community, Multilib repositories
echo "Installing category Accessories"

sudo pacman -S --noconfirm --needed cronie # For cronjobs
sudo pacman -S --noconfirm --needed flameshot # For screenshoots
sudo pacman -S --noconfirm --needed variety # For changin wallpapers

echo "Installing category Development"

sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed python python2

echo "Installing category Graphics"

sudo pacman -S --noconfirm --needed gimp
sudo pacman -S --noconfirm --needed eog

echo "Installing category Internet"

sudo pacman -S --noconfirm --needed chromium
sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed hexchat
sudo pacman -S --noconfirm --needed qbittorrent
sudo pacman -S --noconfirm --needed lynx
sudo pacman -S --noconfirm --needed tor

echo "Installing category Multimedia"

sudo pacman -S --noconfirm --needed mpv
sudo pacman -S --noconfirm --needed simplescreenrecorder
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed youtube-dl

echo "Installing category Office"

sudo pacman -S --noconfirm --needed evince
sudo pacman -S --noconfirm --needed libreoffice-fresh

echo "Installing category System"

sudo pacman -S --noconfirm --needed accountsservice
sudo pacman -S --noconfirm --needed bleachbit
sudo pacman -S --noconfirm --needed curl
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed glances
sudo pacman -S --noconfirm --needed gnome-disk-utility
sudo pacman -S --noconfirm --needed gnome-keyring
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed grsync
sudo pacman -S --noconfirm --needed gvfs gvfs-mtp
sudo pacman -S --noconfirm --needed hardinfo
sudo pacman -S --noconfirm --needed hddtemp
sudo pacman -S --noconfirm --needed htop
sudo pacman -S --noconfirm --needed kvantum-qt5
sudo pacman -S --noconfirm --needed kvantum-theme-arc
sudo pacman -S --noconfirm --needed lm_sensors
sudo pacman -S --noconfirm --needed lsb-release
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed net-tools
sudo pacman -S --noconfirm --needed noto-fonts
sudo pacman -S --noconfirm --needed numlockx
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed polkit-gnome
sudo pacman -S --noconfirm --needed qt5ct
sudo pacman -S --noconfirm --needed sane
sudo pacman -S --noconfirm --needed screenfetch
sudo pacman -S --noconfirm --needed sysstat
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed termite
sudo pacman -S --noconfirm --needed thunar
sudo pacman -S --noconfirm --needed thunar-archive-plugin
sudo pacman -S --noconfirm --needed thunar-volman
sudo pacman -S --noconfirm --needed ttf-ubuntu-font-family
sudo pacman -S --noconfirm --needed ttf-droid
sudo pacman -S --noconfirm --needed tumbler
sudo pacman -S --noconfirm --needed vnstat
sudo pacman -S --needed --noconfirm virtualbox-host-modules-arch
sudo pacman -S --needed --noconfirm virtualbox
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed wmctrl
sudo pacman -S --noconfirm --needed unclutter
sudo pacman -S --noconfirm --needed rxvt-unicode
sudo pacman -S --noconfirm --needed urxvt-perls
sudo pacman -S --noconfirm --needed xdg-user-dirs
sudo pacman -S --noconfirm --needed xdo
sudo pacman -S --noconfirm --needed xdotool
sudo pacman -S --noconfirm --needed zenity
sudo pacman -S --noconfirm --needed man
sudo pacman -S --noconfirm --needed cmake
sudo pacman -S --noconfirm --needed ranger
sudo pacman -S --noconfirm --needed rofi
sudo pacman -S --noconfirm --needed reflector
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed dnsutils

###############################################################################################

# installation of zippers and unzippers
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils uudeview arj cabextract file-roller tar bzip2 gzip p7zip

echo ""

# -------------------
# AUR Packages
# -------------------

echo "Installing yay"

if [[ ! command -v yay ]]
then
        cd ~
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~/InstallArch/InstallBswpm
 else
        echo "Yay installed, skipping..."
 fi

echo "Installing category Accessories"

yay -S --noconfirm conky-lua-archers
yay -S --noconfirm python2-pyparted

echo "Installing category Multimedia"

yay -S --noconfirm gradio

echo "Installing category System"

yay -S --noconfirm downgrade
yay -S --noconfirm font-manager-git
yay -S --noconfirm inxi
yay -S --noconfirm oxy-neon
yay -S --noconfirm pamac-aur
yay -S --noconfirm sardi-icons
yay -S --noconfirm sardi-orb-colora-variations-icons-git
yay -S --noconfirm surfn-icons-git
yay -S --noconfirm the_platinum_searcher-bin
yay -S --noconfirm ttf-font-awesome
yay -S --noconfirm ttf-mac-fonts
yay -S --noconfirm nerd-fonts-hack 
yay -S --noconfirm vivaldi
yay -S --noconfirm oblogout

# these come always last

yay -S --noconfirm hardcode-fixer-git
sudo hardcode-fixer

echo "" 

# -------------------------
# Arch Linux Repo Distro Specific
# -------------------------

echo "DESKTOP SPECIFIC APPLICATIONS"

echo "Installing category Accessories"

sudo pacman -S xfce4-terminal --noconfirm --needed

echo "Installing category System"

sudo pacman -S arandr --noconfirm --needed
sudo pacman -S awesome-terminal-fonts --noconfirm --needed
sudo pacman -S picom  --noconfirm --needed
sudo pacman -S dmenu  --noconfirm --needed
sudo pacman -S feh --noconfirm --needed
sudo pacman -S gtop --noconfirm --needed
sudo pacman -S imagemagick --noconfirm --needed
sudo pacman -S lxappearance-gtk3 --noconfirm --needed
sudo pacman -S lxrandr --noconfirm --needed
sudo pacman -S nitrogen --noconfirm --needed
sudo pacman -S playerctl --noconfirm --needed
sudo pacman -S rofi --noconfirm --needed
sudo pacman -S thunar --noconfirm --needed
sudo pacman -S w3m  --noconfirm --needed
sudo pacman -S xfce4-appfinder --noconfirm --needed
sudo pacman -S xfce4-power-manager --noconfirm --needed
sudo pacman -S xfce4-screenshooter --noconfirm --needed
sudo pacman -S xfce4-settings --noconfirm --needed
sudo pacman -S xfce4-taskmanager --noconfirm --needed
sudo pacman -S xfce4-notifyd --noconfirm --needed

echo ""

# ----------------------
# Aur Repo Specific
# ----------------------

echo "AUR - DESKTOP SPECIFIC APPLICATIONS "

yay -S --noconfirm gtk2-perl

yay -S --noconfirm perl-linux-desktopfiles

yay -S --noconfirm xtitle

yay -S --noconfirm polybar

yay -S --noconfirm urxvt-resize-font-git

yay -S --noconfirm --needed betterlockscreen

echo ""

# --------------------
# Fonts
# --------------------

echo "Installing fonts and themes from Arch Linux repo"

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
sudo pacman -S breeze --noconfirm --needed

echo ""

# ----------------
# Pentesting
# ----------------

echo "Installing Tools for Pentesting"

# Pacman repo
sudo pacman -S --noconfirm --needed nmap
sudo pacman -S --noconfirm --needed aircrack-ng
sudo pacman -S --noconfirm --needed bettercap
sudo pacman -S --noconfirm --needed inetutils
sudo pacman -S --noconfirm --needed openssh
sudo pacman -S --noconfirm --needed iputils traceroute whois dnsutils
sudo pacman -S --noconfirm --needed impacket
sudo pacman -S --noconfirm --needed hydra
sudo pacman -S --noconfirm --needed john hashcat
sudo pacman -S --noconfirm --needed nikto
sudo pacman -S --noconfirm --needed sqlmap
sudo pacman -S --noconfirm --needed wireshark-qt tcpdump
sudo pacman -S --noconfirm --needed proxychains-ng
sudo pacman -S --noconfirm --needed dsniff
sudo pacman -S --noconfirm --needed ettercap-gtk
sudo pacman -S --noconfirm --needed hping
sudo pacman -S --noconfirm --needed ngrep
sudo pacman -S --noconfirm --needed metasploit
sudo pacman -S --noconfirm --needed masscan

# AUR Repo
yay -S --noconfirm --needed dirb gobuster-git wfuzz-git dirbuster
yay -S --noconfirm --needed burpsuite
yay -S --noconfirm --needed exploit-db-git
yay -S --noconfirm --needed crunch

echo ""


# ----------------
# Personal Configuration
# ----------------

sudo pacman -S --noconfirm --needed telegram-desktop
sudo pacman -S --noconfirm --needed vim tmux

# Antivirus
sudo pacman -S --noconfirm --needed clamav

# Criptography
sudo pacman -S --noconfirm --needed gnupg

