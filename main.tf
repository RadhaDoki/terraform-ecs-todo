
    resource "aws_vpc","my-vpc" {
        name = "my-vpc"
        type = "string"
        cidr_block = var.vpc_cidr
        enable_dns_support = true
        enable_dns_hostnames = true
       
    }
    resource "aws_subnet","public-sub"{
        name = "public-sub"
        vpc.id = aws_vpc.my-vpc.id
        cidr_block = var.public_subnet_cidr
        availability_zone = var.availability_zone
        map_public_ip_on_launch = true
    }
    resouce "aws_internet_gateway","my-igw"{
        name = "my-igw"
        type = "string"
    }
    resource "aws_route_table","public-rt"{
        name = "public-rt"
        type = "string"
        source = "my-igw"
        destination = "internet"
    }
    resouce "aws_security_group","my-ec2_sg"{
        name = "my-ec2_sg"
        type = "string"
        Description = sg for EC2  instance map_public_ip_on_launch
        vpc_cidr = var.aws_vpc.my-vpc.id
    
        ingress {
            description = "SSH access"
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = [var.my_ip]

        egress :
            from_port = 0
            to_port = 0
            protocal = "-1"
            cidr_block = [0.0.0.0/0]

    }


    
# 7. Look up the latest available Amazon Linux 2023 AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# 8. EC2 instance
resource "aws_instance" "nginx_ec2" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_sub.id
  vpc_security_group_ids      = [aws_security_group.my_ec2_sg.id]
  associate_public_ip_address = true

  # Install and start Nginx at boot
  user_data = <<-EOF
    #!/bin/bash
    dnf install -y nginx
    systemctl enable --now nginx
  EOF

  tags = {
    Name = "nginx-ec2"
  }
}