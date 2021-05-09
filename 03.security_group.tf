resource "aws_security_group" "allow-ssh" {
    name_prefix = var.namespace
    description = "Alow SSH inbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.namespace
    }
}

resource "aws_security_group" "allow-psql-vpc" {
    name_prefix = var.namespace
    description = "Alow Postgres inbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = var.cidr_blocks
    }

    tags = {
        Name = var.namespace
    }
}

resource "aws_security_group" "allow-psql-world" {
    name_prefix = var.namespace
    description = "Alow Postgres inbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.namespace
    }
}

resource "aws_security_group" "allow-http" {
    name_prefix = var.namespace
    description = "Alow HTTP inbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.namespace
    }
}

resource "aws_security_group" "allow-https" {
    name_prefix = var.namespace
    description = "Alow HTTPs inbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.namespace
    }
}

resource "aws_security_group" "allow-mlsfarm" {
    name_prefix = var.namespace
    description = "Alow MLSFarm inbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    ingress {
        from_port = 5000
        to_port = 5100
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.namespace
    }
}

resource "aws_security_group" "allow-outbound" {
    name_prefix = var.namespace
    description = "Alow all outbound traffic"
    vpc_id      = aws_vpc.mlsfarm.id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = var.namespace
    }
}
