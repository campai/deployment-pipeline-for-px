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

module "network" {
  source            = "./modules/network"
  security_group_id = [module.security.security_group_id]
  cidr_block        = var.subnet_cidr
  vpc_cidr          = var.vpc_cidr
  nic_private_ip    = var.nic_private_ip
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

resource "aws_instance" "web-server-instance" {
  ami               = var.instance_ami
  instance_type     = var.webserver_instance_type
  availability_zone = var.availability_zone
  key_name          = var.instance_key_name

  network_interface {
    device_index         = 0
    network_interface_id = module.network.webserver_nic_id
  }

  user_data = file("scripts/webserver-data.sh")

  tags = {
    "Name" = "webserver"
  }
}
