# Ensure the target directory exists
create_vuln_app_dir:
  file.directory:
    - name: /var/www/html/vuln-app
    - user: www-data
    - group: www-data
    - mode: 755
    - order: 1

# Copy index.php to /var/www/html/vuln-app
move_index_php:
  file.managed:
    - name: /var/www/html/vuln-app/index.php
    - source: salt://DCIG_Vagrant/Web_DB/index.php
    - user: www-data
    - group: www-data
    - mode: 644

# Copy logout.php to /var/www/html/vuln-app
move_logout_php:
  file.managed:
    - name: /var/www/html/vuln-app/logout.php
    - source: salt://DCIG_Vagrant/Web_DB/logout.php
    - user: www-data
    - group: www-data
    - mode: 644

# Copy malicious.php to /var/www/html/vuln-app
move_malicious_php:
  file.managed:
    - name: /var/www/html/vuln-app/malicious.php
    - source: salt://DCIG_Vagrant/Web_DB/malicious.php
    - user: www-data
    - group: www-data
    - mode: 644

# Copy profile.php to /var/www/html/vuln-app
move_profile_php:
  file.managed:
    - name: /var/www/html/vuln-app/profile.php
    - source: salt://DCIG_Vagrant/Web_DB/profile.php
    - user: www-data
    - group: www-data
    - mode: 644

# Copy usersdb.sqlite to /var/www/html/vuln-app
move_usersdb_sqlite:
  file.managed:
    - name: /var/www/html/vuln-app/usersdb.sqlite
    - source: salt://DCIG_Vagrant/Web_DB/usersdb.sqlite
    - user: www-data
    - group: www-data
    - mode: 644
