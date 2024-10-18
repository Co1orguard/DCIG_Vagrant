# Combined installation of SQLite3, Apache 2.2, and PHP 5.5
# /srv/salt/apache2.sls

install_apache_repo:
  pkgrepo.managed:
    - name: 'deb http://old-releases.ubuntu.com/ubuntu/ precise main universe'
    - file: /etc/apt/sources.list.d/apache2-old.list
    - require_in:
      - cmd: apt_update

apt_update:
  cmd.run:
    - name: apt-get update
    - unless: dpkg --get-selections | grep apache2.2

apache2-install:
  pkg.installed:
    - name: apache2
    - require:
      - cmd: apt_update

apache2-service:
  service.running:
    - name: apache2
    - enable: True
    - require:
      - pkg: apache2-install
# ------------------------------------------------------
# Installing SQLite3
install_sqlite3:
  pkg.installed:
    - name: sqlite3
# -------------------------------------------------------
# /srv/salt/php5-install.sls

# Adding the repository to install PHP 5.5
install_php_repo:
  pkgrepo.managed:
    - name: 'ppa:ondrej/php5-5.6'
    - require_in:
      - cmd: apt_update

# Runing apt-get update
apt_update:
  cmd.run:
    - name: apt-get update
    - unless: dpkg --get-selections | grep php5

# Installing PHP 5.5
php5-install:
  pkg.installed:
    - name: php5
    - require:
      - cmd: apt_update

# Ensure PHP is running
php5-fpm-service:
  service.running:
    - name: php5-fpm
    - enable: True
    - require:
      - pkg: php5-install

