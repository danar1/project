#!/usr/bin/env bash

set -e 

# Add ansible repository
sudo apt-get update -y
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible

# Install ansible
sudo apt-get update -y
sudo apt install ansible -y

# To use dynamic inventory plugin and for docker container module
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install community.general
