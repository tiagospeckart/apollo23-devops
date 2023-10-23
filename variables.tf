# Definição de variável para o nome da instância EC2
variable "instance_name" {
  # Descrição da variável que explica seu propósito
  description = "Nome da instância EC2"

  # Tipo de dados esperado para a variável (neste caso, uma string)
  type        = string

  # Valor padrão caso nenhum valor seja especificado durante o uso do Terraform
  default     = "apollo23_hackweek_vm"
}
