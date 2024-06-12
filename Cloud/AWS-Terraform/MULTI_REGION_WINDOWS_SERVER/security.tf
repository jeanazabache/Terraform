################## Security Group - Instancia  ##################

resource "aws_security_group" "sg_server_v" {
  provider = aws.virginia
  vpc_id = aws_vpc.vpc_v.id
  tags = {
    Name = "sg-server_1"
  }
  name     = "sg_server_1"


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

################## Security Group - Instancia  ##################

resource "aws_security_group" "sg_server_o" {
  provider = aws.oregon
  vpc_id = aws_vpc.vpc_o.id
  tags = {
    Name = "sg-server_1"
  }
  name     = "sg_server_1"


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

resource "aws_iam_role" "ssm_role_v" {
  provider = aws.virginia
  name = "ssm_role_v"

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

################## Politicas de AWS Session Management ##################

resource "aws_iam_role" "ssm_role_o" {
  provider = aws.oregon
  name = "ssm_role_o"

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

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment_v" {
  provider = aws.virginia
  role       = aws_iam_role.ssm_role_v.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


 ################## EC2 - Profile IAM ##################
 resource "aws_iam_instance_profile" "ssm_instance_profile_v" {
  provider = aws.virginia
  name = "ssm_instance_profile_v"
  role = aws_iam_role.ssm_role_v.name
}


resource "aws_iam_role_policy_attachment" "ssm_policy_attachment_o" {
  provider = aws.oregon
  role       = aws_iam_role.ssm_role_o.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}


 ################## EC2 - Profile IAM ##################
 resource "aws_iam_instance_profile" "ssm_instance_profile_o" {
  provider = aws.oregon
  name = "ssm_instance_profile_o"
  role = aws_iam_role.ssm_role_o.name
}
