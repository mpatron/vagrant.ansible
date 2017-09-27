# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.boot_timeout = 60
  config.vm.hostname = "myvm.jobjects.org"
  config.vm.network :private_network, ip: "192.168.56.140"
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2    
    vb.memory = "2048"
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = 'provision.yml'
    ansible.inventory_path = 'hosts'
    ansible.limit = 'all'
    ansible.verbose        = true
    ansible.install        = true
  end

end
