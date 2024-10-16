# Undo the installation of SQLite3, Apache 2.2, and PHP 5.5

# Remove SQLite3
remove_sqlite3:
  pkg.removed:
    - name: sqlite3

# Remove Apache 2.2
remove_apache2:
  pkg.removed:
    - name: apache2
  service.dead:
    - name: apache2
    - enable: False

# Remove PHP 5.5
remove_php:
  pkg.removed:
    - name: php5

remove_apache2_config:
  file.absent:
    - name: /etc/apache2/apache2.conf

remove_php_config:
  file.absent:
    - name: /etc/php5/apache2/php.ini
