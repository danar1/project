##################################################################################
# Route 53
##################################################################################

resource "aws_route53_zone" "project-zone" {
  name = "project.internal"

  vpc {
    vpc_id = module.vpc.id
  }

  tags = merge(var.tags, map("Name", "project-hosted-zone"))
}


# Records
resource "aws_route53_record" "grafana" {
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "grafana.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.monitoring.grafana_private_ip]
}

resource "aws_route53_record" "prometheus" {
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "prometheus.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.monitoring.prometheus_private_ip]
}

resource "aws_route53_record" "kibana" {
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "kibana.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.logging.kibana_private_ip]
}

resource "aws_route53_record" "elasticsearch" {
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "elasticsearch.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.logging.elasticsearch_private_ip]
}

resource "aws_route53_record" "jenkins-master" {
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "jenkins-master.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.jenkins.jenkins_master_private_ip]
}

resource "aws_route53_record" "jenkins-slave" {
  count = var.jenkins_agent_count
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "jenkins-slave-${count.index}.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.jenkins.jenkins_agents_private_ip[count.index]]
}

resource "aws_route53_record" "ansible" {
  count = var.ansible_count
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "ansible-${count.index}.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [module.ansible.ansible_private_ip[count.index]]
}

resource "aws_route53_record" "bastion" {
  count = 2
  zone_id = aws_route53_zone.project-zone.zone_id
  name    = "bastion-${count.index}.${aws_route53_zone.project-zone.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.bastion[count.index].private_ip]
}



