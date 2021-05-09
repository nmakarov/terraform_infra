output "siloHost" {
  value       = aws_db_instance.mlsfarm.address
}

output "siloEndpoint" {
  value       = aws_db_instance.mlsfarm.endpoint
}

output "mlsfarmHost" {
    value = aws_instance.mlsfarm.public_dns
}

output "mlsfarmEC2ip" {
    value = aws_instance.mlsfarm.public_ip
}

output "efs" {
  value = aws_efs_file_system.mlsfarm.dns_name
}
