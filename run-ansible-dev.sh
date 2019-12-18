#!/usr/bin/env bash

# Run ansible locally
ansible-playbook -i inventory.ini site.yml -vvvv
