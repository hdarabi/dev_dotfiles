##################################################################
# Name        : install
# Description : This is the main script to install required files
#               on ubuntu linux.
# Version     : 0.0.0
# Created On  : 2015-07-10
# Modified On : 2015-07-15
# Author      : Hamid R. Darabi, Ph.D.
##################################################################

clear
echo "Ubuntu development computer installation shell scrip script"

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

echo "configuring R"
source install_r.sh 

echo "linking dotfiles"
mv ~/.vim ~/.vim_old
mv ~/.vimrc ~/.vimrc_old
mv ~/.gitconfig ~/.gitconfig_old
mv ~/.bashrc ~/.bashrc_old
mv ~/.bash_aliases ~/.bash_aliases_old
mv ~/.Rprofile ~/.Rprofile_old
mv ~/.ssh ~/.ssh_old

ln -s ~/dev_dotfiles/ubuntu/dot_vim ~/.vim
ln -s ~/dev_dotfiles/ubuntu/dot_vimrc ~/.vimrc
ln -s ~/dev_dotfiles/ubuntu/dot_gitconfig ~/.gitconfig
ln -s ~/dev_dotfiles/ubuntu/dot_bashrc ~/.bashrc
ln -s ~/dev_dotfiles/ubuntu/dot_bash_aliases ~/.bash_aliases
ln -s ~/dev_dotfiles/ubuntu/dot_Rprofile ~/.Rprofile
ln -s ~/dev_dotfiles/ubuntu/dot_ssh ~/.ssh
