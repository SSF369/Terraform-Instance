
# Creating aws ec2 machine
resource "aws_instance" "web" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.terraformKeyPair.key_name
  vpc_security_group_ids = ["${aws_security_group.terraformSecurityGroup.id}"]
  tags = {
    Name = "Terraform Instance"
  }
}


