# Este output fornece o endereço IP público da instância EC2
output "instance_ip" {
  value = aws_instance.apollo23_backend_vm.public_ip
  description = "O IP público da instância EC2 backend"
}

# Este output fornece o ID da instância EC2
output "instance_id" {
  value = aws_instance.apollo23_backend_vm.id
}

# Este output fornece o nome de domínio público da instância EC2
output "instance_public_dns" {
  value = aws_instance.apollo23_backend_vm.public_dns
}
