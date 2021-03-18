##################################################################################
# logging
##################################################################################

module "logging" {
  source                 = "./modules/logging" 
  private_subnets        = module.vpc.private_subnets
  ssh_security_group_ids = [aws_security_group.bastion-ssh.id, module.ansible.ansible_security_group.id]
  key_name               = aws_key_pair.project_key.key_name
  key_file               = var.key_file
  nat_gw_id              = module.vpc.nat_gw_id[0]
  tags                   = var.tags
  vpc_id                 = module.vpc.id
  port_5601_ips          = var.port_5601_ips
  bastion_public_ips     = aws_instance.bastion.*.public_ip
  consul-security-group  = module.consul.consul_security_group 
  consul-role            = module.consul.consul_role
}