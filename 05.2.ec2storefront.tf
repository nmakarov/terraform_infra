# data "aws_ami" "ubuntu" {
#     most_recent = true
#     filter {
#         name = "name"
#         values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
#     }

#     filter {
#         name = "virtualization-type"
#         values = ["hvm"]
#     }

#     owners = ["099720109477"]
# }

# resource "aws_key_pair" "mlsfarm" {
#     key_name = "mlsfarmkey"
#     public_key = file("files/terraform_rsa.pub")
# }

resource "aws_instance" "mlsfarmStorefront" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.mlsfarm.key_name
    subnet_id = element(aws_subnet.mlsfarm.*.id, 0)
    vpc_security_group_ids = [
        aws_security_group.allow-ssh.id,
        aws_security_group.allow-http.id,
        aws_security_group.allow-https.id,
        aws_security_group.allow-mlsfarm.id,
        aws_security_group.allow-outbound.id
    ]
    connection {
        type = "ssh"
        # host = self.default_ip_address
        host = self.public_ip
        user = "ubuntu"
        private_key = file("~/.ssh/${var.rsa_key}")
    }
    provisioner "remote-exec" {
        scripts = [
            "files/update.sh"
        ]
    }

    depends_on = [aws_efs_mount_target.mlsfarm]

    tags = {
        Name = var.namespace
    }
}

resource "aws_route53_record" "mlsfarm-Storefront" {
    zone_id = "Z09475982WUANOHRLKQJP"
    name    = "storefront.${var.tld}"
    type    = "A"
    ttl     = "60"
    records = [aws_instance.mlsfarmStorefront.public_ip]
}
