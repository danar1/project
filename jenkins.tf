
##################################################################################
# consul
##################################################################################

module "jenkins" {
  source                 = "./modules/jenkins"
  ssh_security_group_ids = [aws_security_group.bastion-ssh.id]
  tags                   = local.common_tags
  vpc_id                 = module.vpc.id
  public_subnet_ids      = module.vpc.public_subnets
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  nat_gw_object          = module.vpc.nat_gw
  bastion_public_ips     = aws_instance.bastion.*.public_ip
  key_file               = var.key_file
  port_80_ips            = var.port_80_ips
  jenkins_agent_count    = var.jenkins_agent_count   
  eks_cluster_id         = module.eks.cluster_id      
  
}