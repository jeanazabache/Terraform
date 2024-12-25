################## EC2 - UBUNTU ##################
resource "aws_instance" "server_ubuntu_1" {
  provider = aws.virginia
  ami             = "ami-0069eac59d05ae12b"  # ID de la AMI de Windows Server
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  key_name        = "keypair-v"
  subnet_id       = aws_subnet.subnet_public_v.id
  vpc_security_group_ids = [ aws_security_group.sg_server_v.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile_v.name

  tags = {
    Name = "Windows Server Virginia"
  }
}


################## EC2 - UBUNTU ##################
resource "aws_instance" "server_ubuntu_2" {
  provider = aws.oregon
  ami             = "ami-07cccf2bd80ed467f"  # ID de la AMI de Windows Server
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  key_name        = "keypair-o"
  subnet_id       = aws_subnet.subnet_public_o.id
  vpc_security_group_ids = [ aws_security_group.sg_server_o.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile_v.name

  tags = {
    Name = "Windows Server Oregon"
  }
}

################## EC2 - UBUNTU ##################
resource "aws_instance" "server_linux" {
  provider = aws.oregon
  ami             = "ami-0b20a6f09484773af"  # ID de la AMI de Windows Server
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  key_name        = "keypair-o"
  subnet_id       = aws_subnet.subnet_public_o.id
  vpc_security_group_ids = [ aws_security_group.sg_server_o.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile_v.name

  tags = {
    Name = "Windows Server Oregon"
  }
}