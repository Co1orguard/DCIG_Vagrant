# Undo the installation of SQLite3, Apache 2.2, and PHP 5.5

# Remove SQLite3
remove_sqlite3:
  pkg.removed:
    - name: sqlite3

# Stop and disable Apache2.2 service
apache2-stop:
  service.dead:
    - name: apache2
    - enable: False

# Uninstall Apache2.2 and remove its configuration files
apache2-uninstall:
  pkg.purged:
    - name: apache2
    - require:
      - service: apache2-stop

# Remove residual Apache configuration directories
remove-apache-conf:
  file.directory:
    - name: /etc/apache2
    - recurse: True
    - force: True
    - require:
      - pkg: apache2-uninstall

# Stop and disable PHP5.5 service (e.g., PHP-FPM, or php-cgi)
php5-fpm-stop:
  service.dead:
    - name: php5-fpm
    - enable: False
    - onlyif: systemctl status php5-fpm

# Uninstall PHP5.5 and remove its configuration files
php5-uninstall:
  pkg.purged:
    - name: php5
    - require:
      - service: php5-fpm-stop

# Remove residual PHP configuration files
remove-php-conf:
  file.directory:
    - name: /etc/php5
    - recurse: True
    - force: True
    - require:
      - pkg: php5-uninstall

# Remove any additional PHP packages installed (like CLI, CGI, or common modules)
remove-php-addons:
  pkg.purged:
    - pkgs:
      - php5-cli
      - php5-cgi
      - php5-common
      - php5-fpm  # Adjust based on what was installed
    - require:
      - pkg: php5-uninstall

# Clean up any PHP/Apache-related logs
remove-logs:
  file.directory:
    - name: /var/log/apache2
    - recurse: True
    - force: True
  file.directory:
    - name: /var/log/php5-fpm
    - recurse: True
    - force: True
    - onfail: 'Logs directory might not exist if services were not running'

