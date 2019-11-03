# VPC
resource "aws_vpc" "greatapp_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "greatapp_vpc_${var.env}"
  }
}

# Provide internet to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.greatapp_vpc.id}"
  tags = {
    Name = "greatapp_igw_${var.env}"
  }
}

# Subnet for EC2
resource "aws_subnet" "public_web" {
  vpc_id                  = "${aws_vpc.greatapp_vpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "greatapp_public_web_${var.env}"
  }
}

# Subnet and Subnet group for RDS
resource "aws_subnet" "public_db_1" {
  vpc_id            = "${aws_vpc.greatapp_vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "greatapp_public_db_${var.env}"
  }
}

resource "aws_subnet" "public_db_2" {
  vpc_id            = "${aws_vpc.greatapp_vpc.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "greatapp_public_db_${var.env}"
  }
}

resource "aws_db_subnet_group" "greatapp_subnet_group" {
  name        = "greatapp_subnet_group_${var.env}"
  subnet_ids  = ["${aws_subnet.public_db_1.id}", "${aws_subnet.public_db_2.id}"]
}

# Route table to associate all subnets with VPC
resource "aws_route_table" "public_rtb" {
  vpc_id = "${aws_vpc.greatapp_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = "greatapp_public_rtb_${var.env}"
  }
}

resource "aws_route_table_association" "public_web" {
  subnet_id      = "${aws_subnet.public_web.id}"
  route_table_id = "${aws_route_table.public_rtb.id}"
}

resource "aws_route_table_association" "public_db_1" {
  subnet_id      = "${aws_subnet.public_db_1.id}"
  route_table_id = "${aws_route_table.public_rtb.id}"
}

resource "aws_route_table_association" "public_db_2" {
  subnet_id      = "${aws_subnet.public_db_2.id}"
  route_table_id = "${aws_route_table.public_rtb.id}"
}
