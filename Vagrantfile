# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "centos/7"
  config.vm.boot_timeout = 60
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2    
    vb.memory = "2048"
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  config.vm.define "node1" do |machine|
    machine.vm.hostname = "node1.jobjects.org"
    machine.vm.network "private_network", ip: "192.168.56.141"
  end

  config.vm.define "node2" do |machine|
    machine.vm.hostname = "node2.jobjects.org"
    machine.vm.network "private_network", ip: "192.168.56.142"
  end

  config.vm.define 'controller' do |machine|
    machine.vm.hostname = "controller.jobjects.org"
    machine.vm.network "private_network", ip: "192.168.56.140"

    machine.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "provision.yml"
      ansible.verbose        = true
      ansible.install        = true
      ansible.limit          = "all" # or only "nodes" group, etc.
      ansible.inventory_path = "hosts"
    end
  end
  
 end
