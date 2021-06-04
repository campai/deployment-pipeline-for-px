variable "jenkins_instance_type" {
  description = "Instance type for Jenkins VMs"
  type        = string
  default     = "t2.micro"
}

variable "private_subnet_hosts" {
  description = "Available private subnet's hosts"
  type        = list(string)
  default = [
    "192.168.1.2",
    "192.168.1.3",
    "192.168.1.8",
    "192.168.1.102"
  ]
}