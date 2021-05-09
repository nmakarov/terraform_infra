# TODO look into EBS (https://cloud.netapp.com/blog/aws-cvo-blg-terraform-ebs-efs-automate-ebs-volumes-efs-filesystems)

# efs-example
resource "aws_efs_file_system" "mlsfarm" {
    creation_token = "mlsfarm"
    performance_mode = "generalPurpose"
    throughput_mode = "bursting"
    # encrypted = "true"
    encrypted = "false"

    tags = {
        Name = var.namespace
    }
}

# efs-mt-example
# resource "aws_efs_mount_target" "efs-mt-example" {
resource "aws_efs_mount_target" "mlsfarm" {
    file_system_id  = aws_efs_file_system.mlsfarm.id
    # subnet_id = "${aws_subnet.subnet-efs.id}"
    subnet_id = element(aws_subnet.mlsfarm.*.id, 0)

    security_groups = [
        aws_security_group.allow-efs.id,
        aws_security_group.allow-outbound.id
    ]
    # vpc_security_group_ids = [
    #     aws_security_group.allow-ssh.id,
    #     aws_security_group.allow-http.id,
    #     aws_security_group.allow-https.id,
    #     aws_security_group.allow-mlsfarm.id,
    #     aws_security_group.allow-outbound.id
    # ]
}

# ingress-efs-test
resource "aws_security_group" "allow-efs" {
    name_prefix = var.namespace
    vpc_id      = aws_vpc.mlsfarm.id
    # name = "mlsfarm-efs-ie"

    // NFS
    # ingress {
    #     security_groups = ["${aws_security_group.ingress-test-env.id}"]
    #     from_port = 2049
    #     to_port = 2049
    #     protocol = "tcp"
    # }

    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Terraform removes the default rule
    # egress {
    #     security_groups = ["${aws_security_group.ingress-test-env.id}"]
    #     from_port = 0
    #     to_port = 0
    #     protocol = "-1"
    # }

    tags = {
        Name = var.namespace
    }
}
