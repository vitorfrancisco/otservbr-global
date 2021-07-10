#!/bin/bash
ulimit -c unlimited
sudo service mysql restart
sudo service apache2 restart
while true; do ./otbr 2>&1 | awk '{ print strftime("%F %T - "), 
$0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"; done
