Vagrant.configure("2") do |config|
  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "bento/ubuntu-20.04"
    ubuntu.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    ubuntu.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
      vb.gui = true
    end

    ubuntu.vm.provision "shell", inline: <<-SHELL

      # Pulls necessary scripts and configs
      wget https://github.com/Co1orguard/DCIG_Vagrant/releases/download/Intro/linux.zip

      # Installs unzip
      sudo apt install unzip -y

      # Extracts files into /vagrant and removes zip file
      sudo unzip linux.zip -d /vagrant
      sudo mv /vagrant/linux/* /vagrant/
      sudo rm linux.zip
      sudo rm -r /vagrant/linux

      # Runs script that updates, upgrades, and installs necessary packages
      sudo apt install dos2unix -y 
      sudo dos2unix /vagrant/installs.sh 
      sudo bash /vagrant/installs.sh

      # Cleaning up
      sudo rm /vagrant/installs.sh

      # Release Aeacus
      sudo dos2unix /opt/aeacus/ReadMe.conf
      cd /opt/aeacus
      sudo ./aeacus --verbose readme
      sudo ./aeacus --verbose release

      # Reboots system for changes to take effect
      sudo reboot

    SHELL
  end

  config.vm.define "windows" do |windows|
    windows.vm.box = "StefanScherer/windows_10"
    windows.vm.synced_folder ".", "/vagrant"

    windows.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
      vb.gui = true
    end

    windows.vm.provision "shell", inline: <<-SHELL
      
      # make some space for us to work with
      mkdir -Force C:/aeacus/windows
      
      # pull the setup executable for git
      Start-BitsTransfer -Source https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe -Destination C:/Users/vagrant/Documents/Git_Setup.exe
        
      C:/Users/vagrant/Documents/Git_Setup.exe /VERYSILENT
      Start-Sleep -Seconds 60
      rm -Force C:/Users/vagrant/Documents/Git_Setup.exe
      dir "C:/Program Files/"
      
      Set-Location C:/aeacus
      & "C:/Program Files/Git/bin/git.exe" clone https://github.com/Co1orguard/DCIG_Vagrant.git
      # unzip the source
      copy -Recurse -Force C:/aeacus/DCIG_Vagrant/Windows/* C:/aeacus/windows
      
      powershell -ExecutionPolicy Bypass -File windows/installs.ps1

    SHELL
  end
end
