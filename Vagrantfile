# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"
    config.vm.box_version = "20241002.0.0"
    config.disksize.size = "250GB"

    if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
    end
  
    config.vm.provider "virtualbox" do |vb|
      vb.name = "ubuntu-lts-dev"
      vb.cpus = 4
      vb.memory = 6144
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end

    config.vm.provision "tools", type: "shell", path: "provision/install-tools.sh"
    config.vm.provision "docker", type: "shell", path: "provision/install-docker.sh"
    config.vm.provision "k8s", type: "shell", path: "provision/install-k8s-tools.sh"
    config.vm.provision "node", type: "shell", path: "provision/install-node.sh"
    config.vm.provision "java", type: "shell", path: "provision/install-java.sh"
    config.vm.provision "go", type: "shell", path: "provision/install-go.sh"
    config.vm.provision "claude-code", type: "shell", path: "provision/install-claude-code.sh"
    config.vm.provision "terraform", type: "shell", path: "provision/install-terraform.sh"
    config.vm.provision "azure-cli", type: "shell", path: "provision/install-azure-cli.sh"
    config.vm.provision "aws-cli", type: "shell", path: "provision/install-aws-cli.sh"
    config.vm.provision "gcloud-cli", type: "shell", path: "provision/install-gcloud-cli.sh"
    config.vm.provision "shell", inline: <<-SHELL
      # Enable strict shell behavior:
      # -e  exit immediately if a command fails
      # -u  treat unset variables as errors
      # -x  print commands as they execute (useful for provisioning logs)
      # -o pipefail fail if any command in a pipeline fails
      set -euxo pipefail

      echo "adding env for pip3"
      grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' /home/vagrant/.bashrc || \
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/vagrant/.bashrc
  
      echo "setup ssh keys if available"
      VAGRANT_SSH=/home/vagrant/.ssh
      VAGRANT_PROVISION_FILES=/vagrant/provision/files
      VAGRANT_PROVISION_FILES_KEY="${VAGRANT_PROVISION_FILES}/id_rsa"
      VAGRANT_PROVISION_FILES_PUBKEY="${VAGRANT_PROVISION_FILES}/id_rsa.pub"
  
      if [ -f "$VAGRANT_PROVISION_FILES_KEY" ] && [ -f "$VAGRANT_PROVISION_FILES_PUBKEY" ]; then

        echo "installing ssh key files"
        install -d -m 700 -o vagrant -g vagrant "$VAGRANT_SSH"
        install -m 600 -o vagrant -g vagrant "$VAGRANT_PROVISION_FILES_KEY" "${VAGRANT_SSH}/id_rsa"
        install -m 644 -o vagrant -g vagrant "$VAGRANT_PROVISION_FILES_PUBKEY" "${VAGRANT_SSH}/id_rsa.pub"

      else
        echo "Error: SSH key files not found (${VAGRANT_PROVISION_FILES_KEY}, ${VAGRANT_PROVISION_FILES_PUBKEY}) in ${VAGRANT_PROVISION_FILES}."
      fi
  
      echo "add vagrant user to docker"
      usermod -aG docker vagrant || true
  
      echo "VM IP Address:"
      ip -4 addr show | awk '/inet / && $2 !~ /^127/ {print $2}' | cut -d/ -f1
  
      echo "if you used powershell or some windows based terminal make sure to change permission of your private key."
    SHELL
  end
