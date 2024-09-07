#!/bin/bash

# Updates and upgrades system
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Installs desktop environment and display manager
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ubuntu-desktop
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y gdm3

# Start display manager
sudo systemctl start gdm3

# Install necessary packages
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unzip

# Install Aeacus
wget https://github.com/elysium-suite/aeacus/releases/download/v2.1.1/aeacus-linux.zip

# Extracts zip into /opt
sudo unzip aeacus-linux.zip -d /opt

# Move extracted files into /opt/aeacus
sudo mv /opt/aeacus-linux/ /opt/aeacus

# Removes zip file
rm aeacus-linux.zip

# Moves scoring config into /opt/aeacus
if [ ! -f /opt/aeacus/scoring.conf ]; then
  sudo mv /vagrant/scoring.conf /opt/aeacus/scoring.conf
fi

# Moves readme into /opt/aeacus
if [ ! -f /opt/aeacus/ReadMe.conf ]; then
  sudo mv /vagrant/ReadMe.conf /opt/aeacus/ReadMe.conf
fi

# Disables ssh
sudo systemctl disable ssh
sudo systemctl stop ssh
