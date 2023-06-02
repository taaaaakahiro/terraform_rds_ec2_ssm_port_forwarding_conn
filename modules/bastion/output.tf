output "instance_id" {
  value = aws_instance.this.id
}

output "db_instance_endpint" {
    value = aws_db_instance.mysql_standalone.address
}

output "db_instance_username" {
    value = aws_db_instance.mysql_standalone.username
}

output "db_password" {
    value = random_string.db_password.result
}