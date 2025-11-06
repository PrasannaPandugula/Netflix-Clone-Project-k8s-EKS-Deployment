locals {
  org     = "prasanna"
  project = "netflix clone"
  env     = var.env

}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr-block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-vpc"
    Env  = "${local.env}"
  }
}

# gate way creation
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-igw"
    Env  = "${local.env}"
  }

  depends_on = [aws_vpc.vpc]
}

# subnet creation
resource "aws_subnet" "public_subnet" {
  for_each = tomap(var.pub-cidr-block)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-public-subnet-${each.value.cidr}"
    Env  = "${local.env}"
  }

  depends_on = [aws_subnet.public_subnet]
}

# route table 
resource "aws_route_table" "awt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-public-route-table"
    Env  = "${local.env}"
  }

  depends_on = [aws_vpc.vpc]
}

# route table association
resource "aws_route_table_association" "public-art" {

  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.awt.id
}

# Security group

resource "aws_security_group" "asg" {
  name        = "${local.org}-${local.project}-${local.env}-asg"
  description = "default security group"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${local.org}-${local.project}-${local.env}-asg"
    Env  = "${local.env}"
  }

}