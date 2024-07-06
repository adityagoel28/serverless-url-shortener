data "aws_subnets" "default_vpc" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0e308951736835f9b"]
  }
}

data "aws_security_group" "default_security_group" {
  id = "sg-0afbba45359a1c521"
}