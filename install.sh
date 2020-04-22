#!/bin/bash

install_basics=false
install_vb_additions=false
install_vs_code=false

install_everythingelse=false


#sudo apt  update
#sudo apt dist-upgrade

if[ "$install_basics" = true ]
   sudo apt install xorg gdm3 gnome-session # Basics for use interface
fi

#Virtual Box Additions
if [ $install_vb_additions ]
then
   sudo apt install build-essential dkms linux-headers-$(uname -r)
   mkdir -p /mnt/cdrom
   mount /dev/cddrom /mnt/cdrom

   cd /mnt/cdrom/
   sh ./VBoxLinuxAdditions.run --nox11
fi

if [ $install_software_dependencies ]
   sudo apt install curl autoconf bison libxml2-dev

   sudo apt-get update && sudo apt-get install autoconf bison build-essential curl gettext libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev
fi

# Install VS Code
if [ $install_vs_code ]
then
   curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
   sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
   sudo apt updade
   sudo apt install code
fi

if [ $install_google_chrome ]
   # Install Google Chrome
   wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   sudo dpkg -i google-chrome-stable_current_amd64.deb
   rm google-chrome-stable_current_amd64.deb
fi


if [ $install_everythingelse ]
then
   # Install Git
   sudo apt install git



   # Install Flat Remix theme
   cd ~
   mkdir tmp
   cd tmp


   git clone https://github.com/daniruiz/flat-remix
   git clone https://github.com/daniruiz/flat-remix-gtk

   mkdir -p ~/.icons && mkdir -p ~/.themes
   cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/


   git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

   source .bashrc

   asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

   bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring


   # Install Ruby
   asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
   asdf install ruby 2.6.3


   # Install PHP
   asdf plugin-add php https://github.com/asdf-community/asdf-php.git

   asdf install php 7.2.30

   # Install TMUX
   apt install tmux
fi

export . $HOME/.asdf/asdf.sh