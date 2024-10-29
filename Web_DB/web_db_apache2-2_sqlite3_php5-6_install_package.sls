#WED+DB
#Combined installation of SQLite3, Apache 2.2, and PHP 5.6
#--------------------INSTALLING PHP 5.6 ---------------------------
install_software_properties_common:
  cmd.run:
    - name: sudo apt install software-properties-common -y
    - order: 1

add_php_repository:
  cmd.run:
    - name: sudo add-apt-repository -y ppa:ondrej/php
    - order: 2

install_php56:
  cmd.run:
    - name: sudo apt install php5.6 -y
    - order: 3

#-----------------INSTALLING APACHE 2.2 ---------------------------
apache22:
  pkg.installed:
    - name: apache2
    - order: 4
  cmd.run:
    - name: sudo systemctl enable apache2
    - require: 
      - pkg: apache22
    - order: 5
#-----------------INSTALLING SQLITE3 ------------------------------

install_sqlite3:
#  pkg.installed:
   cmd.run:
    - name: sudo apt install sqlite3
    - order: 6
    
install_php5.6_sqlite3:
  pkg.installed:
    - name: php5.6-sqlite3
    - order: 7

