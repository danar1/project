# BASTION INSTANCES
resource "aws_instance" "bastion" {
  count                       = 2
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.project_key.key_name
  subnet_id                   = module.vpc.public_subnets[count.index] 
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion-ssh.id]

  tags = merge(local.common_tags, map("Name", "bastion-${count.index + 1}"))
}

resource "aws_security_group" "bastion-ssh" {
  vpc_id = module.vpc.id
  name   = "bastion-ssh-access"

  tags = merge(local.common_tags, map("Name", "ssh-to-bastion"))
}

resource "aws_security_group_rule" "ssh-access" {
  description       = "bastion allow ssh access from anywhere"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-ssh.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-outbound-anywhere" {
  description       = "bastion allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-ssh.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}