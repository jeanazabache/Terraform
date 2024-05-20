################## SEGURITY GROUPS - UBUNTU ##################
resource "aws_security_group" "ec2_sg" {
  provider = aws.virginia
  name     = "ec2-security-group"
  vpc_id   = aws_vpc.vpc_virginia.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [aws_vpc.vpc_oregon.cidr_block]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc_oregon.cidr_block]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  tags = {
    Name = "ec2-security-group"
  }
}


################## SEGURITY GROUPS RDS MYSQL ##################
resource "aws_security_group" "rds_sg" {
  provider = aws.oregon
  name     = "rds-security-group"
  vpc_id   = aws_vpc.vpc_oregon.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

################## SEGURITY GROUPS - WINDOWS SERVER ##################
resource "aws_security_group" "windows_server_sg" {
  provider = aws.oregon
  name     = "windows-server-security-group"
  vpc_id   = aws_vpc.vpc_oregon.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [aws_vpc.vpc_virginia.cidr_block]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc_virginia.cidr_block]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "windows-server-security-group"
  }
}
