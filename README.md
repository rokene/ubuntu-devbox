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

<!-- note: separate windows vs linux setup -->

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

## Add SSH Keys

Place your ssh keys with default names in the provision files directory:

```
provision/files/id_rsa
provision/files/id_rsa.pub
```

## Configure SSh Config

> For more information: https://code.visualstudio.com/docs/remote/ssh

```powershell
> vagrant ssh-config

Host ubuntu-devbox-lts
    HostName 127.0.0.1
    User vagrant
    Port 2222
    UserKnownHostsFile /dev/null
    StrictHostKeyChecking no
    PasswordAuthentication no
    IdentityFile C:/Users/roken/.vagrant.d/insecure_private_keys/vagrant.key.ed25519
    IdentityFile C:/Users/roken/.vagrant.d/insecure_private_keys/vagrant.key.rsa
    IdentitiesOnly yes
    LogLevel FATAL
    PubkeyAcceptedKeyTypes +ssh-rsa
    HostKeyAlgorithms +ssh-rsa
```

Place everything under `Host` into your ssh-config found in your `<windows home>\.ssh`.

Make sure that your keys defined by `IdentityFile` only have your username with full control on windows.

# Usage

## Start VM

`vagrant up`

## Shutdown VM

`vagrant halt`

## Delete VM

`vagrant destroy`

## Update VM

> This shouldn't be necessary `vagrant up` should run this automatically. However, this can be used to update the VM or blow away the VM and "re-up".

`vagrant provision`
