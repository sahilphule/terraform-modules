output "rds-db-address" {
  description = "rds db host address"
  value       = aws_db_instance.rds-db-instance[*].address
}

output "bastion-host-public-ip" {
  description = "bastion host public ip address"
  value       = aws_instance.bastion-host[*].public_ip
}
