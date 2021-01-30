ops-base
=========

Base setup for EC2 instances:
- install consul

Requirements
------------



Role Variables
--------------

- consul_version - Set consul version [default 1.8.5]
- consul_servers_count - set num of consul servers [default 3]

Dependencies
------------



Example Playbook
----------------

```
---
- name: Install Consul
  hosts: consul_cluster
  become: true
  roles:
    - role: ops-base
      # vars:
      #   consul_version: "1.8.5"
      #   consul_servers_count: "3"
```


Run
----------------

ansible-playbook -i aws_ec2.yml setup_env.yml -e ansible_python_interpreter=/usr/bin/python3

### To disable skipped hosts logs in stdout
- In /etc/ansible/ansible.cfg, set display_skipped_hosts = no

License
-------

BSD

Author Information
------------------

Dana Regev via opsschool
