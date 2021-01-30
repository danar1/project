
##################################################################################
# consul
##################################################################################

module "consul" {
  source                 = "./modules/consul" 
  consul_servers_count   = var.consul_servers_count
  instance_type          = var.consul_instance_type
  subnet_ids             = module.vpc.private_subnets
  key_name               = var.key_name
  ssh_security_group_ids = [aws_security_group.bastion-ssh.id]
  port_8500_ips          = var.port_8500_ips
  tags                   = local.common_tags
  vpc_id                 = module.vpc.id
  enabled_metrics        =  var.consul_asg_enabled_metrics
}