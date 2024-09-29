#!/bin/bash

# Installs desktop environment and display manager
sudo DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-desktop
sudo DEBIAN_FRONTEND=noninteractive apt install -y gdm3

# Start display manager
sudo systemctl start gdm3

# Install necessary packages
sudo DEBIAN_FRONTEND=noninteractive apt install -y unzip
sudo DEBIAN_FRONTEND=noninteractive apt install -y vsftpd

# Install Aeacus
wget https://github.com/elysium-suite/aeacus/releases/download/v2.1.1/aeacus-linux.zip

# Extracts zip into /opt
sudo unzip aeacus-linux.zip -d /opt

# Move extracted files into /opt/aeacus
sudo mv /opt/aeacus-linux/ /opt/aeacus

# Removes zip file
rm aeacus-linux.zip

# Copies scoring config into /opt/aeacus
if [ ! -f /opt/aeacus/scoring.conf ]; then
  sudo cp /vagrant/scoring.conf /opt/aeacus/scoring.conf
fi