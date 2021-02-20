
##################################################################################
# consul
##################################################################################

module "jenkins" {
  source                  = "./modules/jenkins"
  ssh_security_group_ids  = [aws_security_group.bastion-ssh.id, module.ansible.ansible_security_group.id]
  # tags                    = local.common_tags
  tags                    = var.tags
  vpc_id                  = module.vpc.id
  # public_subnet_ids      = module.vpc.public_subnets
  key_name                = var.key_name
  public_subnets          = module.vpc.public_subnets
  private_subnets         = module.vpc.private_subnets
  # nat_gw_object           = module.vpc.nat_gw
  nat_gw_id               = module.vpc.nat_gw_id[0]
  bastion_public_ips      = aws_instance.bastion.*.public_ip
  key_file                = var.key_file
  port_80_ips             = var.port_80_ips
  jenkins_agent_count     = var.jenkins_agent_count   
  eks_cluster_id          = module.eks.cluster_id  
  jenkins_ec2_policy_name = var.jenkins_ec2_policy_name
  jenkins_ec2_role_name   = var.jenkins_ec2_role_name    
  
}