# Virtual Machines
# Local VM helpers for Vagrant/VirtualBox environments.

SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help

VAGRANT ?= vagrant

.PHONY: help \
	start \
	stop \
	destroy \
	update \
	reload \
	status \
	ssh \
	provision

help: ## Show available targets
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.-]+:.*## / {printf "%-28s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: ## Start Ubuntu Dev LTS VM
	$(VAGRANT) up

stop: ## Stop Ubuntu Dev LTS VM
	$(VAGRANT) halt

destroy: ## Destroy Ubuntu Dev LTS VM
	$(VAGRANT) destroy -f
	rm -rf .vagrant

update: ## Rebuild VM from latest configured box
	$(VAGRANT) box update
	$(VAGRANT) destroy -f
	$(VAGRANT) up

reload: ## Reload Ubuntu Dev LTS VM
	$(VAGRANT) reload

status: ## Show VM status
	$(VAGRANT) status

ssh: ## SSH into Ubuntu Dev LTS VM
	$(VAGRANT) ssh

provision: ## Re-run provisioning
	$(VAGRANT) provision
