resource "aws_db_instance" "mlsfarm" {
    db_subnet_group_name          = aws_db_subnet_group.mlsfarm.name

    engine                   = "postgres"
    engine_version           = "12.5"
    identifier               = "mlsfarm"
    instance_class           = "db.t2.micro"
    multi_az                 = false
    name                     = "mlsfarm"
    # parameter_group_name     = "mydbparamgroup1" # if you have tuned it
#   password                 = "${trimspace(file("${path.module}/secrets/mydb1-password.txt"))}"

    username                 = "mlsfarm"
    password                 = "19462786"
    port                     = 5432
    publicly_accessible      = true

    # storage_encrypted        = true # you should always do this
    allocated_storage        = 20 # gigabytes
    storage_type             = "gp2"
    # storage autoscaling?

    backup_retention_period  = 7   # in days

    vpc_security_group_ids = [
        aws_security_group.allow-psql-world.id,
        aws_security_group.allow-psql-vpc.id,
        aws_security_group.allow-outbound.id
    ]
    tags = {
        Name = var.namespace
    }
}

resource "aws_route53_record" "mlsfarm-silo" {
    zone_id = "Z09475982WUANOHRLKQJP"
    name    = "silo.${var.tld}"
    type    = "CNAME"
    ttl     = "60"
    records = [aws_db_instance.mlsfarm.address]
}
