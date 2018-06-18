#!/bin/bash
default_path_user=$HOME
echo "|-----------------------------------------------------------------|"
echo "|Author: Adriano Rusinelli Antonucci                              |"
echo "|E-mail: adriano@adrianoantonucci.com.br                          |"
echo "|Home page: htts://adrianoantonucci.com                           |"
echo "|This script install development enviroment php rails java        |"
echo "|-----------------------------------------------------------------|"
echo ""
#Begin functions
function SystemInfo(){
    /usr/bin/lsb_release -ds
}

function update_repositories(){
    echo Update repositories...
    if ! sudo apt-get update
    then
        echo "Unable to update repositories. Check your file /etc/apt/sources.list"
        exit 1
    fi
    clear
    echo "Success update!"
}
function update_packages(){
    if ! apt-get dist-upgrade -y
    then
        echo "Could not update packages."
        exit 1
    fi
    echo "Succees update!"
}
function install_php_environment(){
    apt-get install nginx
    apt-get install mysql-server

    apt-get install php-fpm php-mysql php-pdo php-mbstring php-dom -y

    #sevice nginx restart
    #service php-fpm restart

    cd $default_path_user
    cd Downloads

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"

   mv composer.phar /usr/bin/composer
   clear
   echo "Install git"
   sleep 2
   apt-get install git
   echo "Git install succeess!"
   sleep 3
   echo "Enter your name for git:"
   read user

   echo "Enter your e-mail for git:"
   read email
   clear
   git config --global color.ui true
   git config --global user.name "$user"
   git config --global user.email "$email"
   ssh-keygen -t rsa -b 4096 -C "$email"
   cat ~/.ssh/id_rsa.pub
   clear
   echo "Install npm nodejs gulp bower"
   sleep 2
   clear
   apt-get install npm
   clear
   npm install -g node
   clear
   npm install -g gulp
   clear
   npm install -g bower
   clear
}
# End functions
# Begin Install
SystemInfo
echo "Starting installation of your environment"
sleep 2
echo "Updating all repositories"
sleep
update_repositories
sleep 2
clear
echo "Updating packages already installed"
update_packages
sleep 2
clear
echo "Install php environment"
install_php_environment
