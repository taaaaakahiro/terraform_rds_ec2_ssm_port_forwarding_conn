output "ec2_instance_id" {
  value = module.rds_bastion.instance_id
}

output "rds_instance_endpint" {
    value = module.rds_bastion.db_instance_endpint
}

output "rds_instance_username" {
    value = module.rds_bastion.db_instance_username
}

output "rds_instance_password" {
    value = module.rds_bastion.db_password
}
