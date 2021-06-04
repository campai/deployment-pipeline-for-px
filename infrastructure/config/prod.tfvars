webserver_instance_type = "t2.micro"

subnet-cidr    = "10.0.1.0/24"
nic-private-ip = "10.0.1.13"

webserver_subnet_hosts = [
  "10.0.1.3",
  "10.0.1.4",
  "10.0.1.5",
  "10.0.1.6",
]