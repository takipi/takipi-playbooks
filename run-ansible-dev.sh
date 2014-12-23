#!/usr/bin/env bash

# Run ansible locally
ansible-playbook -i inventory.ini /vagrant/site.yml -vvvv
