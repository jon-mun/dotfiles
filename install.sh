#!/bin/bash
# Install Ansible if not present
sudo pacman -S --needed ansible

# Run the playbook
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --ask-become-pass
