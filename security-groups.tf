resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

# resource "aws_security_group" "ssh-from-bastion" {
#   name        = "ssh-from-bastion"
#   description = "Allow ssh from bastion"
#   vpc_id = module.vpc.id
  

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     security_groups = [aws_security_group.bastion-ssh.id]
#   }

#   egress {
#     description = "Allow all outgoing traffic"
#     from_port = 0
#     to_port = 0
#     // -1 means all
#     protocol = "-1"
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]
#   }
# }

# resource "aws_security_group" "allow-8080-from-the-world" {
#   name        = "allow-8080-from-the-world"
#   description = "Allow 8080 from the world"
#   vpc_id = module.vpc.id
  

#   ingress {
#     from_port = 8080
#     to_port = 8080
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#     # security_groups = [aws_security_group.jenkins-lb-sg.id]
#   }

#   egress {
#     description = "Allow all outgoing traffic"
#     from_port = 0
#     to_port = 0
#     // -1 means all
#     protocol = "-1"
#     cidr_blocks = [
#       "0.0.0.0/0"
#     ]
#   }
# }