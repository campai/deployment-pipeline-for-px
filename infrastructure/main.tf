provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "project-x-vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    "Name" = "Project-X VPC"
  }
}

resource "aws_subnet" "production-subnet" {
  vpc_id     = aws_vpc.project-x-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    "Name" = "Prod"
  }
}

resource "aws_subnet" "dev-subnet" {
  vpc_id            = aws_vpc.project-x-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "Dev"
  }
}

resource "aws_internet_gateway" "project-x-internet-gateway" {
  vpc_id = aws_vpc.project-x-vpc.id

  tags = {
    "Name" = "Project-X GW"
  }
}

resource "aws_route_table" "project-x-route-table" {
  vpc_id = aws_vpc.project-x-vpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.project-x-internet-gateway.id
  }
}

resource "aws_route_table_association" "prod-route" {
  subnet_id      = aws_subnet.production-subnet.id
  route_table_id = aws_route_table.project-x-route-table.id
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
  subnet_id       = aws_subnet.production-subnet.id
  private_ip      = "10.0.1.13"
  security_groups = [aws_security_group.allow-web.id]
}

resource "aws_eip" "web-server-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.13"
  depends_on = [
    aws_internet_gateway.project-x-internet-gateway
  ]
}

resource "aws_instance" "web-server-instance" {
  ami               = "ami-8964614021ce1"
  instance_type     = "t2.micro"
  availability_zone = "eu-east-1a"
  key_name          = "webserver-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = file("scripts/webserver-data.sh")

  tags = {
    "Name" = "webserver"
  }
}
