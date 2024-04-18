# Vagrant Setup

> In order for vagrant to be able to reconfigure disk space easily install the following plugin: `vagrant plugin install vagrant-disksize`

Ubuntu Latest LTS: 22.04

Following tools will be installed:
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

## Pre-Requisites

- WSL2 (optional)
- VirtualBox

## Usage

> Older vagrant does not support accepting alternate vagrantfile locations.

In order to use vagrant, move to the vagrant directory.

`cd ./tools/vagrant`

Stand up vagrant box.

`vagrant up`

Get ssh-config for use with vscode. For more information: https://code.visualstudio.com/docs/remote/ssh

`vagrant ssh-config`

Shutdown vagrant box.

`vagrant halt`

Delete vagrant box.

`vagrant destroy`

### Install Plugins

To install the vagrant disk management:

`vagrant plugin install vagrant-disksize`
