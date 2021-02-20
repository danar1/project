##################################################################################
# Ansible
##################################################################################

module "ansible" {
  source                  = "./modules/ansible" 
  ansible_count           = var.ansible_count
  ami                     = var.ansible_ami
  instance_type           = var.ansible_instance
  tags                    = var.tags
  vpc_id                  = module.vpc.id
  subnet_ids              = module.vpc.private_subnets
  key_name                = aws_key_pair.project_key.key_name
  key_file                = var.key_file
  # ansible-sg              = [aws_security_group.bastion-ssh.id]
  # ansible-sg              = [aws_security_group.bastion-ssh.id]
  bastion_public_ips      = aws_instance.bastion.*.public_ip
  ssh_security_group_ids  = [aws_security_group.bastion-ssh.id]
  ansible_ec2_role_name   = var.ansible_ec2_role_name
  ansible_ec2_policy_name = var.ansible_ec2_policy_name
  ansible_folder          = var.ansible_folder
}