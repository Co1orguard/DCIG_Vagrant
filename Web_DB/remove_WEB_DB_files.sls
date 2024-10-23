# Remove index.php from /var/www/html/vuln-app
remove_index_php:
  file.absent:
    - name: /var/www/html/vuln-app/index.php
    - order: 1

# Remove logout.php from /var/www/html/vuln-app
remove_logout_php:
  file.absent:
    - name: /var/www/html/vuln-app/logout.php
    - order: 2

# Remove malicious.php from /var/www/html/vuln-app
remove_malicious_php:
  file.absent:
    - name: /var/www/html/vuln-app/malicious.php
    - order: 3

# Remove profile.php from /var/www/html/vuln-app
remove_profile_php:
  file.absent:
    - name: /var/www/html/vuln-app/profile.php
    - order: 4

# Remove usersdb.sqlite from /var/www/html/vuln-app
remove_usersdb_sqlite:
  file.absent:
    - name: /var/www/html/vuln-app/usersdb.sqlite
    - order: 5

# Remove the /var/www/html/vuln-app directory after all files are removed
remove_vuln_app_dir:
  file.absent:
    - name: /var/www/html/vuln-app
    - order: 6
