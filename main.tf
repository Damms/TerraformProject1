resource "aws_vpc" "phob_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "phob_subnet" {
  vpc_id                  = aws_vpc.phob_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "phob_igw" {
  vpc_id = aws_vpc.phob_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "phob_public_rt" {
  vpc_id = aws_vpc.phob_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.phob_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.phob_igw.id
}

resource "aws_route_table_association" "phob_public_assoc" {
  subnet_id      = aws_subnet.phob_subnet.id
  route_table_id = aws_route_table.phob_public_rt.id
}

resource "aws_security_group" "phob_sg" {
  name        = "dev-sg"
  description = "dev security group"
  vpc_id      = aws_vpc.phob_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["125.237.201.82/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "phob_auth" {
  key_name   = "phob-key"
  public_key = file("~/.ssh/phobkey.pub")
}

resource "aws_instance" "dev_node" {
  instance_type = "t2.micro"
  ami = data.aws_ami.server_ami.id
  key_name = aws_key_pair.phob_auth.id
  vpc_security_group_ids = [aws_security_group.phob_sg.id]
  subnet_id = aws_subnet.phob_subnet.id
  user_data = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "dev-node"
  }
}