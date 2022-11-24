terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.31.0"
    }
  }
}

data "aws_ami" "amazon_linux" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name = "architecture"
    values= ["x86_64"]
  }

  filter {
    name = "image-type"
    values = ["machine"]
  }

  filter {
    name = "is-public"
    values = [true]
  }

  filter {
    name = "description"
    values = ["Amazon Linux 2 Kernel 5.10 AMI 2.0.20220805.0 x86_64 HVM gp2"]
  }
}

provider "aws" {
  region  = "ap-northeast-1"
}

variable "public_key_file" {
  type        = string
  description = "Path to a file containing a public key (e.g., ~/.ssh/id_rsa.pub) to create a key pair. The corresponding private key will be used to SSH into the instance"
  default     = "~/.ssh/id_rsa.pub"
}

resource "aws_key_pair" "instance_key" {
  key_name   = "instance_key"
  public_key = file(var.public_key_file)
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "allow SSH to ec2 instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "route_table_assocation" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.amazon_linux.image_id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id              = aws_subnet.subnet.id
  key_name               = aws_key_pair.instance_key.key_name
  instance_type          = "t2.micro"
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.instance.id
  vpc      = true
}

output "ec2_instance_public_ip" {
  value = aws_eip.elastic_ip.public_ip
}
