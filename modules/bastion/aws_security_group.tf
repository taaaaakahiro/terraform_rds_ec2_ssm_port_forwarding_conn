resource "aws_security_group" "rds_bastion_sg" {
  name   = "${var.env}-${var.service}-rds-bastion-sg"
  vpc_id = aws_vpc.this.id
  tags = {
    Environment = var.env
    Name        = "${var.env}-${var.service}-rds-bastion-sg"
  }
}

resource "aws_security_group" "vpce_sg" {
  name   = "${var.env}-${var.service}-rds-bastion-vpce-sg"
  vpc_id = aws_vpc.this.id
  tags = {
    Environment = var.env
    Name        = "${var.env}-${var.service}-rds-bastion-vpce-sg"
  }
}