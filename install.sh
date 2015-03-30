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
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install vim
sudo apt-get install git
sudo apt-get install curl
sudo apt-get install r-base
sudo apt-get instal r-base-dev
wget http://download1.rstudio.org/rstudio-0.98.1103-amd64.deb
sudo dpkg -i *.deb
rm *.deb
sudo apt-get -f install

echo "configuring git"
git config --global user.name "Hamid R. Darabi, Ph.D."
git config --global user.email "hdarabi@gmail.com"
git config --core.editor vim

echo "configuring vim"


echo "configuring R"
source r_config.sh 

echo "linking dotfiles"
