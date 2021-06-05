output "vpc_id" {
  value = aws_vpc.project-x-vpc.id
}

output "webserver_nic_id" {
  value = aws_network_interface.web-server-nic.id
}
