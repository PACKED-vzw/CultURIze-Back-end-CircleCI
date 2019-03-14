#!/bin/bash
#
# Author: Nastasia Vanderperren (PACKED/VIAA)
# Goal: script to deploy the CultURIze files to the webserver
#
##############################################

cd ~/CultURIze-Back-end-CircleCI

echo "start git"
git reset --hard
git pull
git checkout master

echo "start copying files to webserver"
cp -r * /var/www/html/
if [ -f .htaccess ]; then
    cp .htaccess /var/www/html/
fi

echo "script finished"
