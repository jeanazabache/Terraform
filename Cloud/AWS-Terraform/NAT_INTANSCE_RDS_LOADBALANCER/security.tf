################## Security Group - Instancia 1 ##################

resource "aws_security_group" "sg_server_ubuntu_private_1" {
  tags = {
    Name = "sg-server_1"
  }
  name     = "ec2-UBUNTU-group"

  vpc_id   = aws_vpc.vpc.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"

    security_groups = [aws_security_group.load_balancer.id]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}
################## Security Group - Instancia 2 ##################

resource "aws_security_group" "sg_server_ubuntu_private_2" {
  tags = {
    Name = "sg-server_2"
  }

  vpc_id   = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    
    security_groups = [aws_security_group.load_balancer.id]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }   
}

################## Security Group - RDS ##################

resource "aws_security_group" "rds" {
  tags = {
    Name = "sg-rds"
  }

  vpc_id   = aws_vpc.vpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }   
}

################## Security Group - Balanceador de Carga ##################

resource "aws_security_group" "load_balancer" {
  tags = {
    Name = "Load Balancer"
  }

  vpc_id   = aws_vpc.vpc.id
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
}


################## Politicas de AWS Session Management ##################

resource "aws_iam_role" "ssm_role" {
  name = "ssm_role"

  assume_role_policy = jsonencode({
    Version: "2012-10-17",
    Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid    = ""
            Principal = {
              Service = "ec2.amazonaws.com"
            }
          },
        ]
})
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


 ################## EC2 - Profile IAM ##################
 resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm_instance_profile"
  role = aws_iam_role.ssm_role.name
}
