# Undo the installation of SQLite3, Apache 2.2, and PHP 5.5
#--------------------REMOVING PHP 5.6 ---------------------------
remove_php56:
  pkg.removed:
    - name: php5.6
    - order: 1

remove_php_repository:
  cmd.run:
    - name: sudo add-apt-repository --remove -y ppa:ondrej/php
    - require:
      - pkg: remove_php56
    - order: 2

remove_software_properties_common:
  pkg.removed:
    - name: software-properties-common
    - require:
      - cmd: remove_php_repository
    - order: 3

#-----------------REMOVING APACHE 2.2 ---------------------------
stop_apache22:
  service.dead:
    - name: apache2
    - oder: 4

remove_apache22:
  cmd.run:
    - name: sudo apt-get purge apache2 -y
    - order: 5
#-----------------REMOVING SQLITE3 ------------------------------
remove_sqlite3:
  pkg.removed:
    - name: sqlite3
    - order: 6

remove_php5.6_sqlite3:
  pkg.removed:
    - name: php5.6-sqlite3
    - order: 7

#--------------------CLEANUP UNNEEDED PACKAGES -------------------
autoremove_packages:
  cmd.run:
    - name: sudo apt-get autoremove -y

clean_package_cache:
  cmd.run:
    - name: sudo apt-get clean
    - require:
      - cmd: autoremove_packages
