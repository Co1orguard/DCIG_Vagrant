#WED+DB
# Combined installation of SQLite3, Apache 2.2, and PHP 5.6

#--------------------INSTALLING PHP 5.6 ---------------------------
install_software_properties_common:
  pkg.installed:
    - name: software-properties-common
    - order: 1

add_php_repository:
  cmd.run:
    - name: sudo add-apt-repository -y ppa:ondrej/php
    - require:
      - pkg: install_software_properties_common
    - order: 2

update_package_list:
  cmd.run:
    - name: sudo apt-get update
    - require:
      - cmd: add_php_repository
    - order: 3

install_php56:
  pkg.installed:
    - name: php5.6
    - require:
      - cmd: update_package_list
    - order: 4

#-----------------INSTALLING APACHE 2.2 ---------------------------
apache22:
  pkg:
    - installed
    - name: apache2.2
    - version: 2.2.*
    - order: 5
  service:
    - running
    - enable: True
    - order: 6
  config:
    - file: /etc/apache2/apache2.conf
      contents: |
        # Apache 2.2 configuration
        ServerName example.com
        DocumentRoot /var/www/html
    - order: 7
#-----------------INSTALLING SQLITE3 ------------------------------

install_sqlite3:
  pkg.installed:
    - name: sqlite3
    - order: 8

