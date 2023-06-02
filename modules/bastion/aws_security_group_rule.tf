# # aws_security_group_rule.tf

# resource "aws_security_group_rule" "this" {
#   security_group_id        = aws_security_group.rds_bastion_sg.id
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.rds_bastion_sg.id
# }

resource "aws_security_group_rule" "rds_bastion_ingress_rule" {
  security_group_id = aws_security_group.rds_bastion_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rds_bastion_egress_rule" {
  security_group_id = aws_security_group.rds_bastion_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "vpce_ingress_rule" {
  security_group_id = aws_security_group.vpce_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "vpce_egress_rule" {
  security_group_id = aws_security_group.vpce_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
}