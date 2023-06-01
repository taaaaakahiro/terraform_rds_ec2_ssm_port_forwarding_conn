resource "aws_iam_role" "this" {
  name                = "${var.env}-${var.service}-rds-bastion-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "RDSBastionRole"
    }
  ]
}
EOF
}

# data "aws_iam_policy" "systems_manager" {
#   arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }