##################################################################
# Name        : update.sh
# Description : This script automates copying my settings.
# Version     : 0.0.16
# Created On  : 2016-08-30
# Modified On : 2017-04-19
# Author      : Hamid R. Darabi, Ph.D.
##################################################################

git config --global core.autocrlf false

cp '/c/Users/R3PUX/Documents/.R' './dot_r' -r
cp '/c/Users/R3PUX/Documents/.Rprofile' './dot_Rprofile.R'
cp '/c/Users/R3PUX/_vimrc' './dot_vimrc'
cp '/c/Users/R3PUX/.vim/bundle/vim-snippets/snippets' './windows/' -r

git add * --all
git commit -m "$1"
git push origin master
