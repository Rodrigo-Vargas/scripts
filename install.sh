#!/bin/bash

install_basics=false
install_vb_additions=false
install_git=false
install_vs_code=false
install_software_dependencies=false
install_themes=false
install_asdf=true
install_ruby=true
install_everythingelse=false
sleep_time=5

#sudo apt  update
#sudo apt dist-upgrade

if [ "$install_basics" == true ]
then
   echo "**********************************************"
   echo "**************** BASICS **********************"
   echo "**********************************************"

   sleep $sleep_time

   sudo apt install xorg gdm3 gnome-backgrounds gnome-session adwaita-icon-theme-full gnome-themes-standard gnome-control-center gnome-tweaks software-properties-gtk network-manager pulseaudio gnome-terminal nautilus --no-install-recommends -y
fi

#Virtual Box Additions
if [ "$install_vb_additions" == true ]
then
   echo "**********************************************"
   echo "******** Virtual Box Guest Additions *********"
   echo "**********************************************"

   sudo apt install build-essential dkms linux-headers-$(uname -r) -y

   read -n 1 -p "Insira o CD de adicionais de convidado"

   sudo mkdir -p /mnt/cdrom
   sudo mount /dev/cdrom /mnt/cdrom

   cd /mnt/cdrom/
   sudo sh ./VBoxLinuxAdditions.run --nox11
fi

if [ "$install_software_dependencies" == true ]
then
   #sudo apt install curl autoconf bison libxml2-dev

   sudo apt install autoconf bison build-essential curl gettext libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev -y
fi

if [ "$install_git" == true ]
then
   # Install Git
   echo "**********************************************"
   echo "*****************  GIT ***********************"
   echo "**********************************************"

   sudo apt install git

   git config --global user.email "rodrigovargas123@gmail.com"
   git config --global user.name "Rodrigo-vargas"
fi

# Install VS Code
if [ "$install_vs_code" == true ]
then
   curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
   sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
   sudo apt update
   sudo apt install code -y
fi

if [ "$install_google_chrome" == true ]
then
   # Install Google Chrome
   wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   rm google-chrome-stable_current_amd64.deb
fi

if [ "$install_themes" == true ]
then
   # Install Flat Remix theme
   cd ~
   mkdir tmp
   cd tmp

   git clone https://github.com/daniruiz/flat-remix
   git clone https://github.com/daniruiz/flat-remix-gtk

   mkdir -p ~/.icons && mkdir -p ~/.themes
   cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/
fi

if [ "$install_asdf" == true ]
then
   cd ~
   git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

   echo ". $HOME/.asdf/asdf.sh" >> .bashrc

   source ~/.bashrc
fi

if [ "$install_ruby" == true ]
then
   # Install Ruby
   asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
   asdf install ruby 2.6.3
   asdf global ruby  2.6.3
   gem install bundler
   gem install jekyll
fi

if [ "$install_everythingelse" == true ]
then
   asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

   bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

   asdf install nodejs 12.16.2
   asdf global nodejs 12.16.2

   # Install PHP
   asdf plugin-add php https://github.com/asdf-community/asdf-php.git

   asdf install php 7.2.30

   # Install TMUX
   sudo apt install tmux
fi