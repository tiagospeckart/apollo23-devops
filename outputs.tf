# Este output fornece o endereço IP público da instância EC2 banckend
output "instance_ip" {
  value = aws_instance.apollo23_backend_vm.public_ip
  description = "O IP público da instância EC2 backend"
}

# Este output fornece o endereço IP público da instância EC2 frontend
output "frontend_ip" {
  value = aws_instance.apollo23_frontend_vm.public_ip
  description = "O IP público da instância EC2 frontend"
}

# Este output fornece o ID da instância EC2 backend
output "instance_id" {
  value = aws_instance.apollo23_backend_vm.id
}

# Este output fornece o ID da instância EC2 frontend
output "frontend_id" {
  value = aws_instance.apollo23_frontend_vm.id
}

# Este output fornece o nome de domínio público da instância EC2 backend
output "instance_public_dns" {
  value = aws_instance.apollo23_backend_vm.public_dns
}

# Este output fornece o nome de domínio público da instância EC2 frontend
output "frontend_public_dns" {
  value = aws_instance.apollo23_frontend_vm.public_dns
}

# Este output fornece o endpoint do RDS PostgreSQL
output "db_endpoint" {
  value = try(aws_db_instance.db_apollo23.this[0].endpoint, null)
}
