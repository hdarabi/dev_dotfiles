##################################################################
# Name        : update.sh
# Description : This script automates copying my settings.
# Version     : 0.0.5
# Created On  : 2016-08-30
# Modified On : 2016-08-30
# Author      : Hamid R. Darabi, Ph.D.
##################################################################

cp '/c/Users/hamid.darabi/Documents/.R' './' -r

git add * --all
git commit -m "$1"
git push origin master
