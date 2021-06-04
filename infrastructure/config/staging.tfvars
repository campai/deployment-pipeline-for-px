webserver_instance_type = "t2.micro"

subnet-cidr    = "10.0.2.0/24"
nic-private-ip = "10.0.2.13"

webserver_subnet_hosts = [
  "10.0.2.3",
  "10.0.2.13",
]