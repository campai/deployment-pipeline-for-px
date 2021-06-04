webserver_instance_type = "t2.micro"

subnet-cidr    = "10.0.3.0/24"
nic-private-ip = "10.0.3.13"

webserver_subnet_hosts = [
  "10.0.3.10",
  "10.0.3.11",
]