# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-17.04"
  config.vm.network "forwarded_port", guest: 8080, host: 8080 # tileserver-gl
  config.vm.network "forwarded_port", guest: 8888, host: 8888 # maputinik
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt update
    apt -y upgrade
    apt -y install git make bc gawk docker.io docker-compose
    usermod -aG docker vagrant
  SHELL
end
