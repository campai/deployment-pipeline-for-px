output "vpc_id" {
  value = aws_vpc.project_x_vpc.id
}

output "webserver_nic_id" {
  value = aws_network_interface.web_server_nic.id
}
