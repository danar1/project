Env Setup
=========

- cd terraform
- terraform apply
  - provision total of 5 ubuntu18.04 instances: 
    - Three consul servers 
    - One consul agent
    - One instance to run ansible from - for consul cluster configuration management
- On localhost:
  - Requirements:
    - ansible installed
  - cd ansible_setup
  - configure ansible instance public ip in inventory file
  - configure consule cluster instances private ips in external_vars.yml
  - Run:
    - ansible-playbook -i inventory install_ansible.yml
- install consul and apache
  - ssh to ansible instance
  - cd ~/ansible
  - ansible-playbook -i aws_ec2.yml setup_env.yml -e ansible_python_interpreter=/usr/bin/python3
