#!/bin/bash
#Author:      Hamid R. Darabi, Ph.D.
#Title:       Ubuntu development shell
#Version:     0.0.0
#Date:        March 26th, 2015
#Description: In this file I put all the required codes for installing and
#	      running a development environment for myself from scratch.

clear
echo "Ubuntu development computer installation shell scrip scriptt"

echo "installing packages"
sudo dpkg --add-architecture i386
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install curl
sudo apt-get install r-base
sudo apt-get install r-base-dev
sudo apt-get install skype
sudo apt-get install gimp
sudo apt-get install inkscape
sudo apt-get install texlive
wget http://download1.rstudio.org/rstudio-0.98.1103-amd64.deb
sudo dpkg -i *.deb
rm *.deb
sudo apt-get -f install
sudo apt-get install mysql-server


echo "configuring git"
git config --global user.name "Hamid R. Darabi, Ph.D."
git config --global user.email "hdarabi@gmail.com"
git config --core.editor vim

echo "configuring vim"


echo "configuring R"
source install_r.sh 

echo "linking dotfiles"
ln -s ~/dev_dotfiles/dot_vim ~/.vim
ln -s ~/dev_dotfiles/dot_vimrc ~/.vimrc
ln -s ~/dev_dotfiles/dot_gitconfig ~/.gitconfig
ln -s ~/dev_dotfiles/dot_bashrc ~/.bashrc
ln -s ~/dev_dotfiles/dot_bash_aliases ~/.bash_aliases
ln -s ~/dev_dotfiles/dot_Rprofile ~/.Rprofile
ln -s ~/dev_dotfiles/dot_ssh ~/.ssh
