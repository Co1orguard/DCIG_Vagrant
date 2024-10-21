# Undo the installation of SQLite3, Apache 2.2, and PHP 5.5
#--------------------REMOVING PHP 5.6 ---------------------------
remove_php56:
  pkg.removed:
    - name: php5.6
    - require:
      - cmd: update_package_list

remove_php_repository:
  cmd.run:
    - name: sudo add-apt-repository --remove -y ppa:ondrej/php
    - require:
      - pkg: remove_php56

remove_software_properties_common:
  pkg.removed:
    - name: software-properties-common
    - require:
      - cmd: remove_php_repository

#-----------------REMOVING APACHE 2.2 ---------------------------
stop_apache22:
  service.dead:
    - name: apache2
    - require:
      - pkg: remove_apache22

remove_apache22:
  pkg.removed:
    - name: apache2.2
    - require:
      - service: stop_apache22

remove_apache22_config:
  file.absent:
    - name: /etc/apache2/apache2.conf
    - require:
      - pkg: remove_apache22

#-----------------REMOVING SQLITE3 ------------------------------
remove_sqlite3:
  pkg.removed:
    - name: sqlite3

#--------------------CLEANUP UNNEEDED PACKAGES -------------------
autoremove_packages:
  cmd.run:
    - name: sudo apt-get autoremove -y
    - require:
      - pkg: remove_php56
      - pkg: remove_apache22
      - pkg: remove_sqlite3

clean_package_cache:
  cmd.run:
    - name: sudo apt-get clean
    - require:
      - cmd: autoremove_packages
