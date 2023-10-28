# Apollo23 - Grupo 7
![DevOps build CI/CD with Actions](https://github.com/Everton-WS/apollo23-devops/actions/workflows/apollo23.yml/badge.svg)

Projeto do Grupo 7 - Apollo 23, da Hackweek do programa +Devs2Blu 2023.

Este repositório é dedicado a automatizar o processo de provisionamento e configuração de infraestrutura na Amazon Web Services (AWS), do Projeto Hackweek, utilizando as ferramentas Terraform, Ansible e Docker. Nosso fluxo de trabalho do GitHub Actions está configurado para implantar e gerenciar recursos na AWS sempre que houver mudanças na branch principal (main). As credenciais da AWS estão configuradas no Secrets do GitHub, bem como chaves SSH e outras variáveis e parâmetros sensíveis, para através delas personalizar os arquivos Terraform e Ansible de acordo com as necessidades. Este projeto é uma introdução ideal para profissionais de DevOps Júnior que desejam automatizar a infraestrutura na AWS de maneira eficaz.

---

## Problema para Desenvolvimento da Aplicação

Levamos em consideração um problema que a Blusoft enfrenta:

* Pessoas que se inscrevem para palestras gratuitas e acabam não indo, o que gera diversos transtornos.

### Engajamento em eventos

Organizar eventos de tecnologia é uma tarefa desafiadora, que envolve diversos aspectos, desde a logística e a programação até o engajamento dos participantes. Com o crescimento constante da indústria de tecnologia, a realização de eventos bem-sucedidos tornou-se essencial para a disseminação de conhecimento, a promoção de networking e o fortalecimento das comunidades de tecnologia. No entanto, muitas vezes, as equipes de organização enfrentam obstáculos que podem dificultar a comunicação eficiente e o engajamento dos participantes.

## Solução

Incluir uma camada de gamificação e interação ao se inscrever em uma palestra.

* O usuário irá ler QRCodes durante a palestra, essas leituras geram pontos que podem ser utilizados da forma que o organizador achar melhor (sorteios, descontos, prioridade em eventos). Além disso, o histórico de leituras cria uma base de dados que poderá ser utilizada para definição de estratégias.
* O usuário poderá postar perguntas que serão escolhidas para serem feitas ao palestrante. Como as perguntas ficam visíveis no aplicativo, é possível que o palestrante já se prepare baseado no que a platéia tem interesse em saber.

---

## [Repositório Flutter](https://github.com/Everton-WS/apollo23-flutter)

## [Repositório Java](https://github.com/Everton-WS/apollo23-java)

## Instalação e Uso

Para instalar e usar o repositório, você precisará seguir estas etapas:

1.  Crie uma conta no GitHub e clone o repositório para sua máquina local.
2.  Obtenha acesso ao provider cloud AWS.
3.  Insira as seguintes variáveis de ambiente nos Secrets do Github:

```
AWS_ACCESS_KEY_ID: <seu_id_de_acesso_da_aws>
AWS_SECRET_ACCESS_KEY: <sua_chave_secreta_da_aws>
AWS_DEFAULT_REGION: <sua_região_da_aws>
SSH_PRIVATE_KEY: <sua_chave_privada_do_ssh>
TF_VAR_db_username: <nome_de_usuário_do_banco_de_dados>
TF_VAR_db_password: <senha_do_banco_de_dados>

```

4.  Configure o Terraform para seu ambiente.
5.  Faça um push ou pull request na branch "main" do repositório.

O fluxo de trabalho do GitHub será executado e provisionará uma instância AWS e uma aplicação para você.

Após o provisionamento, você poderá acessar a aplicação no seguinte endereço:

```
http://<endereço_ip_da_instância_backend>:8000

```

Para obter mais informações sobre a instalação e o uso do repositório, consulte a documentação do GitHub Actions e do Terraform.

Aqui estão algumas dicas adicionais para usar o repositório:

-   Você pode personalizar o playbook do Ansible para atender às necessidades específicas da sua aplicação.
-   Você pode adicionar etapas ao fluxo de trabalho do GitHub para executar testes ou outras tarefas.
-   Você pode usar o fluxo de trabalho do GitHub para provisionar uma instância AWS e uma aplicação para cada pull request.

## Documentação

### Aplicação DevOps de IaC

Este repositório contém uma implementação DevOps de IaC para uma aplicação web. A aplicação é composta por duas camadas: backend e frontend.

**Estrutura do repositório**

O repositório está organizado da seguinte forma:

-   `.github/workflows`: contém os workflows do GitHub Actions para CI/CD da aplicação.
-   `.gitignore`: contém os arquivos e pastas que devem ser ignorados pelo Git.
-   `LICENSE`: contém a licença da aplicação.
-   `README.md`: este documento.
-   `backend.tf`: contém os recursos do Terraform para o backend da aplicação.
-   `inventory.ini`: contém as configurações do Ansible para o backend da aplicação.
-   `key.tf`: contém a chave pública do SSH para o backend da aplicação.
-   `main.tf`: contém a configuração principal do Terraform.
-   `outputs.tf`: contém as saídas do Terraform.
-   `variables.tf`: contém as variáveis do Terraform.
-   `playbook-back.yml`: contém o playbook do Ansible para o backend da aplicação.
-   `playbook-front.yml`: contém o playbook do Ansible para o frontend da aplicação.

**Arquitetura**

A aplicação usa duas instâncias EC2 separadas, uma para o backend e outra para o frontend, ao implantar na AWS. Essa abordagem é conhecida como arquitetura de várias camadas ou arquitetura em camadas. Cada camada (backend e frontend) é hospedada em uma instância EC2 dedicada, proporcionando isolamento e escalabilidade independentes.

**Recursos definidos**

-   Security Group:  `aws_security_group.apollo23_hackweek_security_group`
-   Instância EC2 para o backend:  `aws_instance.apollo23_backend_vm`
-   Instância EC2 para o frontend:  `aws_instance.apollo23_frontend_vm`
-   Banco de dados RDS PostgreSQL:  `aws_db_instance.db_apollo23`

**Descrição dos recursos**

**Security Group**

O Security Group `aws_security_group.apollo23_hackweek_security_group` permite o tráfego de entrada nas seguintes portas:

-   22: SSH
-   80: HTTP
-   443: HTTPS
-   5432: RDS
-   8000: porta da aplicação

**Instância EC2 para o backend**

A instância EC2 `aws_instance.apollo23_backend_vm` é uma instância do tipo `t2.medium` que executa o sistema operacional Ubuntu. Ela tem associado o Security Group `aws_security_group.apollo23_hackweek_security_group` e o script de inicialização `user_data` que instala o Ansible.

**Instância EC2 para o frontend**

A instância EC2 `aws_instance.apollo23_frontend_vm` é uma instância do tipo `t2.medium` que executa o sistema operacional Ubuntu. Ela tem associado o Security Group `aws_security_group.apollo23_hackweek_security_group`.

**Backend (Java) na EC2**

O backend da aplicação é um servidor Java que é hospedado em uma instância EC2. O backend é responsável por lidar com as solicitações HTTP do frontend e acessar os dados do banco de dados.

**Frontend (Flutter) em outra EC2**

O frontend da aplicação é um aplicativo Flutter que é hospedado em uma instância EC2. O frontend é responsável por renderizar a interface do usuário da aplicação e enviar solicitações HTTP ao backend.

**Conexão com Banco de  dados RDS PostgreSQL**

O backend e o frontend da aplicação se comunicam com um banco de dados RDS PostgreSQL.  O banco de dados RDS PostgreSQL `aws_db_instance.db_apollo23` é uma instância do tipo `db.t3.micro` com 20 GB de armazenamento. Ele tem associado o Security Group `aws_security_group.apollo23_hackweek_security_group` e é publicamente acessível.


**CI/CD**

A aplicação usa o GitHub Actions para CI/CD. Os workflows do GitHub Actions são executados sempre que um novo commit é feito no repositório.

**O workflow de build**

O workflow de build é responsável por compilar o backend e o frontend da aplicação. O backend é compilado usando o Maven e o frontend é compilado usando o Flutter.

**O workflow de deploy**

O workflow de deploy é responsável por implantar o backend e o frontend da aplicação na AWS. O backend é implantado usando o Terraform e o frontend é implantado usando o Ansible.

**Considerações adicionais**

-   Para melhorar a disponibilidade e o desempenho da aplicação, considere o uso de serviços de equilíbrio de carga e monitoramento.
-   Para escalar a aplicação, você pode aumentar o número de instâncias EC2 para cada camada.

**Como contribuir**

Para contribuir com este projeto, envie um pull request.

**Licenciamento**

Esta aplicação é licenciada sob a Licença MIT.

**Mais informações**

Para obter mais informações sobre este projeto, consulte a documentação.


## Requisitos

#### Funcionais
* O sistema deverá instanciar duas instâncias EC2 na AWS: Uma instância backend para executar o backend da aplicação e uma instância frontend para executar o frontend da aplicação.
* O sistema deverá configurar o banco de dados: Criar um banco de dados na AWS e configurar as instâncias EC2 para acessar o banco de dados.
* O sistema deverá instalar o Docker nas instâncias EC2 para executar as aplicaçôes.
* O sistema deverá clonar os repositórios Git com os códigos-fonte das aplicações nas instâncias EC2.
* O sistema deverá fazer o build e implantar a aplicação nas instâncias EC2.

#### Não funcionais

* Segurança: O fluxo de trabalho do GitHub usa chaves SSH para autenticar as instâncias EC2.
* Recursos: O fluxo de trabalho do GitHub usa um bucket S3 para armazenar o arquivo de estado do Terraform.
* Testes: O playbook do Ansible pode ser personalizado para executar testes na aplicação.
 
## Equipe
- Allan Zimmermann
- Antônio Carlos Schwanke Zipf
- Endrigo Gustavo de Oliveira Knetsch
- Everton Wesley da Silva
- Lucas Raulino dos Santos
- Tiago Martins Speckart
- Vinícius dos Santos Guimarães
