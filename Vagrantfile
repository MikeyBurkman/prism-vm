# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# Vagrant configuration for vagrant-jdev-box
# @link
# https://github.com/rob-murray/vagrant-javadev-box
#
Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.box = "precise64"

  # Grab this via `vagrant box add precise64 http://files.vagrantup.com/precise64.box`
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"


  config.vm.network :forwarded_port, guest: 9200, host: 9200 # Elasticsearch
  config.vm.network :forwarded_port, guest: 9201, host: 9201 # Kibana

  config.vm.provision "shell", inline: "apt-get update --fix-missing"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet"
     puppet.manifest_file  = "default.pp"
     puppet.options = "--verbose"
  end

  config.vm.provision "shell", path: "puppet/installEs.sh"

end
