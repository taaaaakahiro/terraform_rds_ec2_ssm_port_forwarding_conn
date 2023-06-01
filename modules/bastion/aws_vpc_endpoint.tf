
resource "aws_vpc_endpoint" "ssm_interface_endpoint" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          =  [aws_subnet.pri_1a.id]
  security_group_ids  = [aws_security_group.vpce_sg.id]
  tags = {
    Name = "${var.env}-${var.service}-rds-bastion-ssm-vpce"
  }
}

resource "aws_vpc_endpoint" "ssmmessages_interface_endpoint" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.pri_1c.id]
  security_group_ids  = [aws_security_group.vpce_sg.id]
  tags = {
    Name = "${var.env}-${var.service}-rds-bastion-ssmmessages-vpce"
  }
}

resource "aws_vpc_endpoint" "ec2messages_interface_endpoint" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.pri_1d.id]
  security_group_ids  = [aws_security_group.vpce_sg.id]
  tags = {
    Name = "${var.env}-${var.service}-rds-bastion-ec2messages-vpce"
  }
}