# -*- mode: ruby -*-
# vi: set ft=ruby :

# set http_proxy=http://xrsl210:d2S%25p8G%40@222.192.20.150:8080
# set https_proxy=%http_proxy%
# vagrant box add centos/7

ENV["LC_ALL"] = "fr_FR.UTF-8"

Vagrant.configure("2") do |config|
  
  # config.proxy.http     = "http://xrsl210:d2S%25p8G%40@222.192.20.150:8080"
  # config.proxy.https    = "http://xrsl210:d2S%25p8G%40@222.192.20.150:8080"
  # config.proxy.no_proxy = "localhost,127.0.0.1"
  puts "proxyconf..."
  if Vagrant.has_plugin?("vagrant-proxyconf")
    puts "find proxyconf plugin !"
    if ENV["http_proxy"]
      puts "http_proxy: " + ENV["http_proxy"]
      config.proxy.http = ENV["http_proxy"]
    end
    if ENV["https_proxy"]
      puts "https_proxy: " + ENV["https_proxy"]
      config.proxy.https = ENV["https_proxy"]
    end
    if ENV["no_proxy"]
      config.proxy.no_proxy = ENV["no_proxy"]
    end
  end

  config.vm.box = "centos/7"
  config.vm.boot_timeout = 60
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2    
    vb.memory = "2048"
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  (1..3).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "node#{i}.jobjects.org"
      node.vm.network "private_network", ip: "192.168.56.14#{i}"
      node.vm.provision "shell", inline: <<-SHELL1
        sudo sed -i -e "\\#PasswordAuthentication no# s#PasswordAuthentication no#PasswordAuthentication yes#g" /etc/ssh/sshd_config
        sudo systemctl restart sshd
      SHELL1
    end
  end

  config.vm.define 'controller' do |machine|
    machine.vm.hostname = "controller.jobjects.org"
    machine.vm.network "private_network", ip: "192.168.56.140"
    machine.vm.provision "shell", inline: <<-SHELL3
      sudo sed -i -e "\\#PasswordAuthentication no# s#PasswordAuthentication no#PasswordAuthentication yes#g" /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL3

    machine.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "provision.yml"
      ansible.verbose        = false
      ansible.install        = true
      ansible.limit          = "all" # or only "nodes" group, etc.
      ansible.inventory_path = "inventory.txt"
    end
  end
  
 end
