#!/usr/bin/env bash

set -e 

# Install pip for python2 and python3
sudo apt-get update -y
sudo apt install python-pip -y
sudo apt install python3-pip -y

# Install  and botocore with pip
pip install boto3
pip install botocore

# Install  and botocore with pip3
pip3 install boto3
pip3 install botocore
