# Definindo o provedor AWS e a região onde os recursos serão criados
provider "aws" {
  region = "us-east-1"  # Escolha a região que preferir
}

# Definindo uma VPC
resource "aws_vpc" "apollo23_vpc" {
  cidr_block = "173.23.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Definindo a Sub-rede Privada
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.apollo23_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

# Definindo a Sub-rede Pública
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.apollo23_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

# Definindo uma tabela de Rotas
resource "aws_route_table" "apollo23_route_table" {
  vpc_id = aws_vpc.apollo23_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.apollo23_igw.id
  }
}

# Associe a tabela de rotas à sub-rede pública
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.apollo23_route_table.id
}

# Crie um gateway de Internet
resource "aws_internet_gateway" "apollo23_igw" {
  vpc_id = aws_vpc.apollo23_vpc.id
}

# Definindo um grupo de segurança (Security Group) na AWS
resource "aws_security_group" "apollo23_hackweek_security_group" {
  name        = "apollo23-hackweek-security-group"
  description = "Security Group para SSH, HTTP, porta 8000 e RDS"

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
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite qualquer endereço IP para HTTPS
  }

  ingress {
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  # Permitir acesso à porta do banco de dados
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

# Definindo uma instância EC2 na AWS para o backend
resource "aws_instance" "apollo23_backend_vm" {
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
    Name        = var.ec2_backend_name
    Environment = "prod"
    Application = "Java"
    Class       = "DevOps"    
  }
}

# Definindo uma instância EC2 na AWS para o frontend
resource "aws_instance" "apollo23_frontend_vm" {
  ami           = "ami-053b0d53c279acc90"  # AMI para o frontend
  instance_type = "t2.medium"  # Tipo de instância para o frontend 
  key_name      = aws_key_pair.apollo23_hackweek_keypair.key_name  # Nome da chave SSH para acessar a instância

  vpc_security_group_ids = [aws_security_group.apollo23_hackweek_security_group.id]  # Associando o mesmo grupo de segurança

  # user_data = <<-EOF
  #             #!/bin/bash
  #             # Configure o frontend Flutter aqui
  #             EOF

  tags = {
    Name        = var.ec2_frontend_name
    Environment = "prod"
    Application = "Flutter"
    Class       = "DevOps"    
  }
}

# # (Opcional) Definindo um balanceador de carga (Load Balancer) para o frontend
# resource "aws_lb" "frontend_load_balancer" {
#   name               = "frontend-load-balancer"
#   internal           = false  # Se true, o balanceador de carga é interno
#   load_balancer_type = "application"

#   enable_deletion_protection = false

#   subnets = ["subnet-xxxxxxxxxxx", "subnet-yyyyyyyyyyy"]  # Subnets onde o balanceador de carga será provisionado

#   enable_http2 = true

#   enable_cross_zone_load_balancing = true

#   security_groups = [aws_security_group.apollo23_hackweek_security_group.id]

#   enable_deletion_protection = false
# }

# # (Opcional) Regras do balanceador de carga (Listeners)
# resource "aws_lb_listener" "frontend_listener" {
#   load_balancer_arn = aws_lb.frontend_load_balancer.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "fixed-response"
#     fixed_response_type = "content-type-text/html"
#     fixed_response_content = "Hello from the frontend!"
#   }
# }

# Definindo o BD RDS PostgreSQL na AWS
resource "aws_db_instance" "db_apollo23" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres15"

  vpc_security_group_ids = [aws_security_group.apollo23_hackweek_security_group.id]

  skip_final_snapshot = true

  tags = {
    Name = "db_apollo23"
  }
}
