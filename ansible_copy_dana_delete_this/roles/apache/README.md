apache
=========

Install apache2

Requirements
------------



Role Variables
--------------



Dependencies
------------



Example Playbook
----------------

```
---
- name: Install apache2
  hosts: consul_agents
  become: true
  vars:
    - consul_agent_name_tag: "opsschool-agent"
  roles:
    - role: apache
      when:
        - hostvars[inventory_hostname].tags.Name is defined
        - hostvars[inventory_hostname].tags.Name == consul_agent_name_tag
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

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
