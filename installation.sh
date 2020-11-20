#!/bin/bash

 # Check if running as root  
 if [ "$(id -u)" != "0" ]; then  
   echo "This script must be run as sudo" 1>&2  
   exit 1  
 fi


<<COMMENT

this file is for installation of
list of installations as follows , please comment to avoid particular package by adding # infront of the command.
Please dont change the order of commands.

net-tools
ssh server
ssh-key generator (public,private key generator for system)
forticlient
filezilla
apache2
php
mysql
phpmyadmin

COMMENT
echo "\n\n"
#to work with net tools like ifconfig commands
 apt install net-tools


echo "\n\n"


# install filezilla   
 apt-get install filezilla   

echo "\n\n"
echo "install ssh-server  -----------------------"
echo "  -----------------------"
 #install ssh-server
 apt-get install openssh-server
 systemctl enable ssh
 systemctl start ssh

echo "\n\n"
#generate sshkey can you generated key for bitbucket and git access via ssh.
ssh-keygen

echo "\n\n"
##------ start of forticlient ---- 

#Install gpg key
wget -O - https://repo.fortinet.com/repo/6.4/ubuntu/DEB-GPG-KEY | apt-key add -

echo "deb [arch=amd64] https://repo.fortinet.com/repo/6.4/ubuntu/ /bionic multiverse" >> /etc/apt/sources.list
apt-get update
apt install forticlient

##--- end of forticlient ---
echo "\n\n"


#Update package lists
 apt-get update

echo "\n\n"
#to install apache
 #apt-get install apache2
 apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y  

echo "\n\n"
#to install php
 apt-get install python-software-properties
 add-apt-repository ppa:ondrej/php

echo "\n\n"
#to install particular version of php
 apt-get install -y php5.6
 apt install libapache2-mod-php php-cli

 a2dismod php7.*
 a2enmod php5.6
 service apache2 restart
 update-alternatives --set php /usr/bin/php5.6
 update-alternatives --set phar /usr/bin/phar5.6
 update-alternatives --set phar.phar /usr/bin/phar.phar5.6

echo "\n\n"

#to install mb-string module in php as phpmyadmin was not working
 apt-get install php5.6-mbstring

echo "\n\n"
#to install mysql module as phpmyadmin was not working
 apt-get install php5.6-mysql

echo "\n\n"
#to install php curl
 apt-get install php5.6-curl

echo "\n\n"
#to install mysql server
 apt install mysql-server
 mysql_secure_installation

echo "\n\n"
#to install phpmyadmin
 apt install phpmyadmin  php-gettext

echo "\n\n"
echo "starting Enabling Mod Rewrite  -----------------------"
echo "  -----------------------"

echo "\n\n"
#Enabling Mod Rewrite  
a2enmod rewrite  


echo "\n\n"
echo "PhpMyAdmin  -----------------------"
echo "  -----------------------"
# Configure PhpMyAdmin  
 echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf  

echo "\n\n"
echo "apache rebooting  -----------------------"
echo "  -----------------------"
#Allow running Apache on boot up
 systemctl enable apache2


echo "\n\n"
#Start Apache server
 systemctl start apache2


echo "\n\n"
# apache service restart
service apache2 restart

echo "\n\n"
echo "Update package lists  -----------------------"
echo "  -----------------------"
#Update package lists
 apt-get update


echo "\n\n"
echo "adjust firewall  -----------------------"
echo "  -----------------------"

echo "\n\n"
#Adjust permissions
 chmod -R 0755 /var/www/html/

echo "\n\n"
#Adjust Firewall
 ufw allow in "Apache Full"
 ufw allow ssh
 ufw enable
 ufw status

 apt-get update
 apt-get autoremove
 apt-get autoclean

echo "\n\n"

echo "\n installation versions are"
echo "\n---------------------------\n"
echo "\n path of php \n"
which php

echo " \n php version\n-------------\n"
php -v

echo "\n mysql path\n-------------\n"
which mysql 

echo "\n mysql version\n-------------\n"
mysql --version

echo "\n apache path\n-------------\n"
which apache2 

echo " \n apache version\n-------------\n"
apache2 -v

echo "\n---------------------------\n"
echo "\n END of installation n"
echo "\n---------------------------\n"
exit 0