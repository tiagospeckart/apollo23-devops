# Definindo o provedor AWS e a região onde os recursos serão criados
provider "aws" {
  region = "us-east-1"  # Escolha a região que preferir
}

# Definindo um grupo de segurança (Security Group) na AWS
resource "aws_security_group" "apollo23_hackweek_security_group" {
  name        = "apollo23-hackweek-security-group"
  description = "Security Group para SSH, HTTP e porta 8000"

  # Regras de ingresso que permitem o tráfego de entrada
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite qualquer endereço IP para SSH
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite qualquer endereço IP para HTTP
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite qualquer endereço IP para a porta 8000
  }

  # Regra de saída que permite todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permite todo o tráfego de saída
  }
}

# Definindo uma instância EC2 na AWS
resource "aws_instance" "apollo23_hackweek_vm" {
  ami           = "ami-053b0d53c279acc90"  # AMI do Ubuntu
  instance_type = "t2.medium"  # Tipo de instância
  key_name      = aws_key_pair.apollo23_hackweek_keypair.key_name  # Chave SSH para acessar a instância

  vpc_security_group_ids = [aws_security_group.apollo23_hackweek_security_group.id]  # Associando o grupo de segurança à instância

  # Configurando o script de inicialização da instância
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update 
              sudo apt-get install -y software-properties-common 
              sudo add-apt-repository --yes ppa:ansible/ansible
              sudo apt-get install -y ansible
              EOF

  # Tags para identificação da instância
  tags = {
    Name        = var.instance_name
    Environment = "prod"
    Application = "Java"
    Class       = "DevOps"    
  }
}
