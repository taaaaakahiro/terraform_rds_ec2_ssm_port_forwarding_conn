resource "aws_instance" "this" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.pri_1a.id
  iam_instance_profile = aws_iam_instance_profile.this.name
  security_groups      = [aws_security_group.rds_bastion_sg.id]
  tags = {
    Name = "${var.env}-${var.service}-rds-bastion"
  }
}