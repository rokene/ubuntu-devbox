# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
  
    if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
    end
  
    config.vm.provider "virtualbox" do |vb|
      # 6 gigs RAM and never use more than 50% of the host cpu
      vb.memory = 6144
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      vb.name = "bionic-devbox"
    end
  
    config.vm.provision "apt-sources", type: "shell", path: "provision/apt-sources.sh"
    config.vm.provision "tools", type: "shell", path: "provision/dev-tools.sh"
    config.vm.provision "docker", type: "shell", path: "provision/docker.sh"
  end
