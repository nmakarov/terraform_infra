resource "aws_vpc" "mlsfarm" {
    cidr_block            = var.vpc_cidr
    instance_tenancy      = "default"
    enable_dns_hostnames  = true
    enable_dns_support = true # ???

    tags = {
        Name = var.namespace
    }
}

resource "aws_internet_gateway" "mlsfarm" {
    vpc_id = aws_vpc.mlsfarm.id

    tags = {
        Name = var.namespace
    }
}

resource "aws_route" "mlsfarm" {
    route_table_id         = aws_vpc.mlsfarm.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.mlsfarm.id
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "mlsfarm" {
    count                   = length(var.cidr_blocks)
    vpc_id                  = aws_vpc.mlsfarm.id
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    cidr_block              = var.cidr_blocks[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = var.namespace
    }
}

resource "aws_db_subnet_group" "mlsfarm" {
    name       = "mlsfarm"
    subnet_ids = aws_subnet.mlsfarm.*.id

    tags = {
        Name = var.namespace
    }
}
