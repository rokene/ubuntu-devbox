# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-22.04"
    config.disksize.size = '250GB'

    if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
    end
  
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 6144
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      vb.name = "dev-ubuntu-lts"
    end

    config.vm.provision "tools", type: "shell", path: "provision/install-tools.sh"
    config.vm.provision "docker", type: "shell", path: "provision/install-docker.sh"
    config.vm.provision "k8s-tools", type: "shell", path: "provision/install-k8s-tools.sh"
    config.vm.provision "node", type: "shell", path: "provision/install-node.sh"
    config.vm.provision "shell", inline: <<-SHELL
  
      echo "adding env for pip3"
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/vagrant/.bashrc
  
      echo "setup ssh keys if available"
      VAGRANT_SSH=/home/vagrant/.ssh
      VAGRANT_PROVISION_FILES=/vagrant/provision/files
      VAGRANT_PROVISION_FILES_KEY=${VAGRANT_PROVISION_FILES}/id_rsa
      VAGRANT_PROVISION_FILES_PUBKEY=${VAGRANT_PROVISION_FILES}/id_rsa.pub
  
      if [ -f "${VAGRANT_PROVISION_FILES}/id_rsa" ] && [ -f "${VAGRANT_PROVISION_FILES}/id_rsa.pub" ]; then
  
        if [ -d $VAGRANT_SSH ]; then
          echo "creating missing ${VAGRANT_SSH}"
          mkdir -p $VAGRANT_SSH
        fi
  
        echo "installing ssh key files"
        chmod 700 $VAGRANT_SSH
        cp ${VAGRANT_PROVISION_FILES}/id_rsa* $VAGRANT_SSH
        chmod 600 $VAGRANT_PROVISION_FILES_KEY
        chown vagrant:vagrant $VAGRANT_PROVISION_FILES_KEY
        chmod 644 $VAGRANT_PROVISION_FILES_PUBKEY
        chown vagrant:vagrant $VAGRANT_PROVISION_FILES_PUBKEY
      else
        echo "Error: SSH key files not found (${VAGRANT_PROVISION_FILES_KEY}, ${VAGRANT_PROVISION_FILES_PUBKEY}) in ${VAGRANT_PROVISION_FILES}."
      fi
  
      echo "add vagrant user to docker"
      sudo usermod -aG docker vagrant
  
      echo "VM IP Address:"
      ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
  
      echo "if you used powershell or some windows based terminal make sure to change permission of your private key."
    SHELL
  end
