resource "aws_vpc" "project-x-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = "Project-X VPC"
  }
}

resource "aws_subnet" "webserver-subnet" {
  vpc_id     = aws_vpc.project-x-vpc.id
  cidr_block = var.cidr_block
  tags = {
    "Name" = "Project-X webserver subnet"
  }
}

resource "aws_internet_gateway" "project-x-internet-gateway" {
  vpc_id = aws_vpc.project-x-vpc.id

  tags = {
    "Name" = "Project-X GW"
  }
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.webserver-subnet.id
  private_ip      = var.nic_private_ip
  security_groups = var.security_group_id
}

resource "aws_eip" "web-server-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = var.nic_private_ip
  depends_on = [
    aws_internet_gateway.project-x-internet-gateway
  ]
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.project-x-vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.project-x-internet-gateway.id
  }
}

resource "aws_route_table_association" "webserver-route" {
  subnet_id      = aws_subnet.webserver-subnet.id
  route_table_id = aws_route_table.route-table.id
}
