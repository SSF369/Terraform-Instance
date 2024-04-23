# Creating key-pair in aws
resource "aws_key_pair" "terraformKeyPair" {
  key_name   = "tfkeys"
  public_key = file("${path.module}/tfkeys.pub")

  tags = {
    Name = "Terraform KeyPair"
  }
}
