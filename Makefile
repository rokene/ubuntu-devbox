# Virtual Machines
# Local VM helpers for Vagrant/VirtualBox environments.

SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help

VAGRANT ?= vagrant

.PHONY: help \
	ubuntu-dev-lts-start \
	ubuntu-dev-lts-stop \
	ubuntu-dev-lts-destroy \
	ubuntu-dev-lts-update \
	ubuntu-dev-lts-reload \
	ubuntu-dev-lts-status \
	ubuntu-dev-lts-ssh \
	ubuntu-dev-lts-provision

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.-]+:.*## / {printf "%-28s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

ubuntu-dev-lts-start: ## Start Ubuntu Dev LTS VM
	$(VAGRANT) up

ubuntu-dev-lts-stop: ## Stop Ubuntu Dev LTS VM
	$(VAGRANT) halt

ubuntu-dev-lts-destroy: ## Destroy Ubuntu Dev LTS VM
	$(VAGRANT) destroy -f
	rm -rf .vagrant

ubuntu-dev-lts-update: ## Rebuild VM from latest configured box
	$(VAGRANT) box update
	$(VAGRANT) destroy -f
	$(VAGRANT) up

ubuntu-dev-lts-reload: ## Reload Ubuntu Dev LTS VM
	$(VAGRANT) reload

ubuntu-dev-lts-status: ## Show VM status
	$(VAGRANT) status

ubuntu-dev-lts-ssh: ## SSH into Ubuntu Dev LTS VM
	$(VAGRANT) ssh

ubuntu-dev-lts-provision: ## Re-run provisioning
	$(VAGRANT) provision
