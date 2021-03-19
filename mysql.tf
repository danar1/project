##################################################################################
# mysql
##################################################################################

module "mysql" {
  source                 = "./modules/mysql" 
  subnet_ids             = module.vpc.private_subnets
  key_name               = aws_key_pair.project_key.key_name
  key_file               = var.key_file
  nat_gw_id              = module.vpc.nat_gw_id
  tags                   = var.tags
  vpc_id                 = module.vpc.id
  port_3306_ips          = var.port_3306_ips
  bastion_public_ips     = aws_instance.bastion.*.public_ip
  consul-security-group  = module.consul.consul_security_group 
  consul-role            = module.consul.consul_role
}