################## EC2 - UBUNTU ##################
resource "aws_instance" "server_ubuntu_1" {
  provider = aws.virginia
  ami             = "ami-0069eac59d05ae12b"  # ID de la AMI de Windows Server
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  key_name        = "keypair-v"
  subnet_id       = aws_subnet.subnet_public_1.id
  vpc_security_group_ids = [ aws_security_group.sg_server.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "Windows Server"
  }
}


################## EC2 - UBUNTU ##################
resource "aws_instance" "server_ubuntu_2" {
  provider = aws.virginia
  ami             = "ami-0069eac59d05ae12b"  # ID de la AMI de Windows Server
  instance_type   = "t3.medium"
  associate_public_ip_address = false # IP Pública
  key_name        = "keypair-v"
  subnet_id       = aws_subnet.subnet_public_1.id
  vpc_security_group_ids = [ aws_security_group.sg_server.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "Windows Server - 2"
  }
}
