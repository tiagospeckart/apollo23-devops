# Define um novo recurso de par de chaves da AWS
resource "aws_key_pair" "apollo23_hackweek_keypair" {
  # Define o nome da chave, que será usado na AWS
  key_name   = "apollo23-hackweek-keypair"

  # Define a chave pública que será usada para a autenticação SSH
  public_key = file("~/.ssh/id_rsa.pub")
}
