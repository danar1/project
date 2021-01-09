#!/usr/bin/env bash

set -e 

sudo apt-get update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu