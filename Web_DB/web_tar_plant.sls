place_tarball:
  file.managed:
    - name: /tmp/html.tar
    - source: salt://html.tar
    - user: www-data
    - group: www-data
    - mode: 777
    - order: 1

untar:
  cmd.run:
    - name: 'sudo tar -C /var/www/ -xvf /tmp/html.tar'
    - order: 2
    
