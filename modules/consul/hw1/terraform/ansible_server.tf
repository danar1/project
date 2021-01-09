data "aws_subnet_ids" "subnets" {
    vpc_id = var.vpc_id
}



resource "aws_security_group" "ansible-sg" {
 name        = "ansible-sg"
 description = "security group for ansible servers"
 vpc_id      = var.vpc_id
  egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

# ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     security_groups = var.port_22_security_groups
#   }

  ingress {
   from_port   = 8
   to_port     = 0
   protocol    = "icmp"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "ansible-server" {
  count = 1

  # ami           = data.aws_ami.ubuntu-18.id
  ami           = "ami-083547ef8b8f5b0bc" # packer AMI
  instance_type = "t2.micro"

  associate_public_ip_address = true

  subnet_id = var.subnet_id

  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  key_name               = var.key_name
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name


  tags = {
    Name = "Ansible-server"
  }

   connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(var.key_file)

  }

  # connection {
  #   bastion_host = aws_instance.bastion[count.index].public_ip
  #   host         = self.private_ip
  #   bastion_user = "ubuntu"
  #   user         = "ec2-user"
  #   private_key  = file(var.key_file)
  # }


  provisioner "file" {
    source      = "ansible"
    destination = "/home/ubuntu"
  }

  provisioner "file" {
      source      = var.key_file
      destination = "/home/ubuntu/.ssh"
    }
}

##################################################################################
# Role (ec2 iam), instance profile
##################################################################################

# EC2 IAM role
resource "aws_iam_role" "ec2-iam-role" {
  name = "project-ec2-iam-ansible-role"
  tags = map("Name", "project-ec2-iam-ansible-role")

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Provides an IAM role inline policy 
resource "aws_iam_role_policy" "ec2-full-access" {
  name = "project-ec2-ansible-policy"
  role = aws_iam_role.ec2-iam-role.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "eks:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

# Instance profile - Create instance profile with the ec2 iam role
resource "aws_iam_instance_profile" "instance_profile" {
  name = "ansible_instance_profile"
  role = aws_iam_role.ec2-iam-role.name
}

 


