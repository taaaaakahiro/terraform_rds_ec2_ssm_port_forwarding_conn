resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-${var.service}-vpc"
  }
}

