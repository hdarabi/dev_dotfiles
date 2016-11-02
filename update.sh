##################################################################
# Name        : update.sh
# Description : This script automates copying my settings.
# Version     : 0.0.12
# Created On  : 2016-08-30
# Modified On : 2016-11-02
# Author      : Hamid R. Darabi, Ph.D.
##################################################################

git config --global core.autocrlf false

cp '/c/Users/hamid.darabi/Documents/.R' './dot_r' -r
cp '/c/Users/hamid.darabi/Documents/.Rprofile' './dot_Rprofile.R'
cp '/c/Users/hamid.darabi/_vimrc' './dot_vimrc'
cp '/c/Users/hamid.darabi/.vim/bundle/vim-snippets/snippets'
'./windows/UltiSnips' -r

git add * --all
git commit -m "$1"
git push origin master
