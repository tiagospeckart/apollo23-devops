# Definição de variável para o nome da instância EC2
variable "ec2_backend_name" {
  # Descrição da variável que explica seu propósito
  description = "Nome da instância EC2 backend"

  # Tipo de dados esperado para a variável (neste caso, uma string)
  type        = string

  # Valor padrão caso nenhum valor seja especificado durante o uso do Terraform
  default     = "apollo23_backend_vm"
}

variable "ec2_frontend_name" {
  # Descrição da variável que explica seu propósito
  description = "Nome da instância EC2 frontend"

  # Tipo de dados esperado para a variável (neste caso, uma string)
  type        = string

  # Valor padrão caso nenhum valor seja especificado durante o uso do Terraform
  default     = "apollo23_frontend_vm"
}

# Definição de variável usuário para o BD RDS PostgreSQL
variable "db_username" {
  # Descrição da variável que explica seu propósito
  description = "Username for the PostgreSQL database"
}

# Definição de variável password para o BD RDS PostgreSQL
variable "db_password" {
  # Descrição da variável que explica seu propósito
  description = "Password for the PostgreSQL database"
}
