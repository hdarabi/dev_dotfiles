##################################################################
# Name        : update.sh
# Description : This script automates copying my settings.
# Version     : 0.0.9
# Created On  : 2016-08-30
# Modified On : 2016-09-01
# Author      : Hamid R. Darabi, Ph.D.
##################################################################

cp '/c/Users/hamid.darabi/Documents/.R' './dot_r' -r
cp '/c/Users/hamid.darabi/Documents/.Rprofile' './dot_Rprofile.R'
cp '/c/Users/hamid.darabi/_vimrc' './dot_vimrc'

git add * --all
git commit -m "$1"
git push origin master
