#!/usr/bin/env bash

# Run ansible locally
ansible-playbook -i inventory /vagrant/site.yml -vvv
