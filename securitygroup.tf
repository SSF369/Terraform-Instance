# Creating Security group
resource "aws_security_group" "terraformSecurityGroup" {
  name        = "personalTFSG"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "Terraform Security Group"
  }
}

# Dynamic ingress rules
locals {
  ingress_ports = var.ports
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each = { for idx, port in local.ingress_ports : idx => port }

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.terraformSecurityGroup.id
}


# # Creating Security group with inbound and outbound rules.
# resource "aws_security_group" "terraformSecurityGroup" {
#   name        = "personalTFSG"
#   description = "Allow TLS inbound traffic and all outbound traffic"


#   tags = {
#     Name = "Terraform Security Group"
#   }
#   dynamic "aws_vpc_security_group_ingress_rule" {
#     for_each = [22, 80, 443, 3306, 27017, 8080]
#     iterator = "port"
#     content {
#       security_group_id = aws_security_group.terraformSecurityGroup.id
#       cidr_ipv4         = "0.0.0.0/0"
#       cidr_ipv6         = "::/0"
#       from_port         = port.value
#       ip_protocol       = "tcp"
#       to_port           = port.value
#     }
#   }
# }

output "securityGroupDetails" {
  value = aws_security_group.terraformSecurityGroup.id

}

# resource "aws_vpc_security_group_ingress_rule" "terraformSecurityGroup_ipv4" {
#   security_group_id = aws_security_group.terraformSecurityGroup.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

# resource "aws_vpc_security_group_ingress_rule" "terraformSecurityGroup_ipv4" {
#   security_group_id = aws_security_group.terraformSecurityGroup.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }
# 
# resource "aws_vpc_security_group_ingress_rule" "terraformSecurityGroup_ipv4" {
#   security_group_id = aws_security_group.terraformSecurityGroup.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

# resource "aws_vpc_security_group_ingress_rule" "terraformSecurityGroup_ipv6" {
#   security_group_id = aws_security_group.terraformSecurityGroup.id
#   cidr_ipv6         = "::/0"
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraformSecurityGroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.terraformSecurityGroup.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}