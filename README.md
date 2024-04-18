# Ubuntu LTS Vagrant DevBox

Ubuntu Latest LTS: 22.04

Following tools will be installed into the Vagrant VM:
- git
- git-completion
- jq
- make
- docker
- python
- kubectl
- kind
- helm3
- nvm
- node lts

# Pre-Requisites

- WSL2 (optional)
- VirtualBox
- Vagrant

## Install VirtualBox

> Disable Hyper-V in Powershell w/ Admin Win10: `Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All`

> Disable Hyper-V in Powershell w/ Admin Win11: `bcdedit /set hypervisorlaunchtype off`

Install latest VirtualBox & VirtualBox Extensions @ https://www.virtualbox.org/wiki/Downloads

## Install Vagrant

Install latest Vagrant @ https://developer.hashicorp.com/vagrant/downloads

### Install Vagrant Plugins

Install this plugin to easily manage disk resizing with Vagrant.

`vagrant plugin install vagrant-disksize`

# Usage

Stand up vagrant box.

`vagrant up`

> For more information: https://code.visualstudio.com/docs/remote/ssh

Retrieve the ssh configuration for this VM.

`vagrant ssh-config`

Shutdown vagrant box.

`vagrant halt`

Delete vagrant box.

`vagrant destroy`
