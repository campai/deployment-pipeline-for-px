terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "project-x-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "Project-X VPC"
  }
}

resource "aws_subnet" "webserver-subnet" {
  vpc_id     = aws_vpc.project-x-vpc.id
  cidr_block = var.subnet-cidr
  tags = {
    "Name" = "Project-X webserver subnet"
  }
}

resource "aws_internet_gateway" "project-x-internet-gateway" {
  vpc_id = aws_vpc.project-x-vpc.id

  tags = {
    "Name" = "Project-X GW"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.project-x-vpc.id

  route {
    cidr_block = var.subnet-cidr
    gateway_id = aws_internet_gateway.project-x-internet-gateway.id
  }
}

resource "aws_route_table_association" "webserver-route" {
  subnet_id      = aws_subnet.webserver-subnet.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_security_group" "allow-web" {
  name        = "allow web traffic"
  description = "Allows HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.project-x-vpc.id

  ingress {
    description = "allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-web"
  }
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.webserver-subnet.id
  private_ip      = var.nic-private-ip
  security_groups = [aws_security_group.allow-web.id]
}

resource "aws_eip" "web-server-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = var.nic-private-ip
  depends_on = [
    aws_internet_gateway.project-x-internet-gateway
  ]
}

resource "aws_instance" "web-server-instance" {
  ami               = var.instance-ami
  instance_type     = var.webserver_instance_type
  availability_zone = var.availability-zone
  key_name          = var.instance-key-name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = file("scripts/webserver-data.sh")

  tags = {
    "Name" = "webserver"
  }
}
