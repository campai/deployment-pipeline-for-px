variable "aws-region" {
  type    = string
  default = "us-east-1"
}

variable "availability-zone" {
  type    = string
  default = "us-east-1a"
}

variable "instance-ami" {
  type    = string
  default = "ami-8964614021ce1"
}

variable "webserver_instance_type" {
  description = "Instance type for VMs"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet-cidr" {
  description = "Project's subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "nic-private-ip" {
  type    = string
  default = "10.0.1.13"
}

variable "webserver_subnet_hosts" {
  description = "Available private subnet's hosts"
  type        = list(string)
  default = [
    "10.0.1.2",
    "10.0.1.3",
  ]
}

variable "instance-key-name" {
  type    = string
  default = "webserver-key"
}
