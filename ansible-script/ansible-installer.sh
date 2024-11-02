#!/bin/bash
sudo apt-get update
yes | sudo apt install software-properties-common
echo "Waiting for 30 seconds before installing the ansible package..."
sleep 30
yes | sudo add-apt-repository --yes --update ppa:ansible/ansible
echo "Waiting for 30 seconds before  add-apt-repository"
sleep 30
yes | sudo apt install ansible

sudo -i
cd /etc/ansible/
mv ansible.cfg ansible.cfg_backup
ansible-config init --disabled > ansible.cfg