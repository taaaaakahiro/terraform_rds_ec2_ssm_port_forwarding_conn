resource "aws_subnet" "pri_1a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"


  tags = {
    Name = "${var.env}-${var.service}-subnet"
  }
}

resource "aws_subnet" "pri_1c" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.2.0/24"
   availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.env}-${var.service}-subnet"
  }
}

resource "aws_subnet" "pri_1d" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.3.0/24"
   availability_zone = "ap-northeast-1d"

  tags = {
    Name = "${var.env}-${var.service}-subnet"
  }
}