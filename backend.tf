# Configuração do backend para armazenar o estado do Terraform em um bucket S3

terraform {
  backend "s3" {
    # Nome do bucket S3 onde o estado do Terraform será armazenado
    bucket         = "apollo23-hackweek-state"

    # Nome do arquivo no bucket que conterá o estado do Terraform
    key            = "terraform.tfstate"

    # Região da AWS onde o bucket S3 está localizado
    region         = "us-east-1"

    # Habilitar a criptografia do estado do Terraform
    encrypt        = true
  }
}