provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "jenkins_machine" {
  ami           = "image code here"
  instance_type = var.jenkins_instance_type

  tags = {
    Name = "jenkins"
  }
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
  vpc_id     = aws_vpc.project-x-vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    "Name" = "Dev"
  }
}

resource "aws_internet_gateway" "project-x-gateway" {
  vpc_id = aws_vpc.project-x-vpc.id

  tags = {
    "Name" = "Project-X GW"
  }
}

resource "aws_route_table" "project-x-route-table" {
  vpc_id = aws_vpc.project-x-vpc.id

  route = []
}
