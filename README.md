# Ubuntu LTS Vagrant DevBox

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

## Windows

### Install VirtualBox

> Disable Hyper-V in Powershell w/ Admin Win10: `Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All`

> Disable Hyper-V in Powershell w/ Admin Win11: `bcdedit /set hypervisorlaunchtype off`

Install latest VirtualBox & VirtualBox Extensions @ https://www.virtualbox.org/wiki/Downloads

### Install Vagrant

Install latest Vagrant @ https://developer.hashicorp.com/vagrant/downloads

#### Install Vagrant Plugins

Install this plugin to easily manage disk resizing with Vagrant.

`vagrant plugin install vagrant-disksize`

## Add SSH Keys

Place your ssh keys with default names in the provision files directory:

```
provision/files/id_rsa
provision/files/id_rsa.pub
```

## Configure SSH Config

> For more information: https://code.visualstudio.com/docs/remote/ssh
> Place the configuration into `.ssh/config`.
> Make sure that your keys defined by `IdentityFile` only have your username with full control on windows.

Obtain the ssh configuration like example below.

```powershell
> vagrant ssh-config
...
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

# Usage

Start: `make ubuntu-dev-lts-start`

Stop: `make ubuntu-dev-lts-stop`

Delete: `make ubuntu-dev-lts-destroy`

Update: `make ubuntu-dev-lts-update`

Reload: `make ubuntu-dev-lts-reload`

Status: `make ubuntu-dev-lts-status`

SSH: `make ubuntu-dev-lts-ssh`

> This shouldn't be necessary `vagrant up` should run this automatically. However, this can be used to update the VM or blow away the VM and "re-up".

Provision: `make ubuntu-dev-lts-provision`
