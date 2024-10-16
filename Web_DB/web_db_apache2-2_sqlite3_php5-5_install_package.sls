# Combined installation of SQLite3, Apache 2.2, and PHP 5.5

# Install SQLite3
install_sqlite3:
  pkg.installed:
    - name: sqlite3

# Install Apache 2.2
install_apache2:
  pkg.installed:
    - name: apache2
    - version: 2.2.*
  service.running:
    - name: apache2
    - enable: True

# Install PHP 5.5
install_php:
  pkg.installed:
    - name: php5
    - version: 5.5.*
  service.running:
    - name: apache2
    - enable: True
