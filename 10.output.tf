output "siloHost" {
  value       = aws_db_instance.mlsfarm.address
}

output "siloEndpoint" {
  value       = aws_db_instance.mlsfarm.endpoint
}

output "efs" {
  value = aws_efs_file_system.mlsfarm.dns_name
}

output "mlsfarm_ec2_host" {
    value = aws_instance.mlsfarm-ec2.public_dns
}

output "mlsfarm_ec2_ip" {
    value = aws_instance.mlsfarm-ec2.public_ip
}

output "mlsfarm_storefront_host" {
    value = aws_instance.mlsfarm-storefront.public_dns
}

output "mlsfarm_storefront_ip" {
    value = aws_instance.mlsfarm-storefront.public_ip
}

