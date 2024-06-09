################## EC2 - UBUNTU ##################
resource "aws_instance" "server_ubuntu_1" {
  provider = aws.virginia
  ami             = var.instance_amis["instance-server"] # ID de la AMI de Ubuntu
  instance_type   = var.type_instance
  associate_public_ip_address = true # IP Pública
  key_name        = var.keypairs["keypair1"]
  subnet_id       = aws_subnet.subnet_private_1.id
  vpc_security_group_ids = [ aws_security_group.sg_server_ubuntu_private_1.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = var.name_instance["name2"]
  }
}



################## EC2 - UBUNTU ##################
resource "aws_instance" "server_ubuntu_2" {
  provider = aws.virginia
  ami             = var.instance_amis["instance-server"] # ID de la AMI de Ubuntu
  instance_type   = var.type_instance
  associate_public_ip_address = true # IP Pública
  key_name        = var.keypairs["keypair1"]
  subnet_id       = aws_subnet.subnet_private_2.id
  vpc_security_group_ids = [ aws_security_group.sg_server_ubuntu_private_2.id]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = var.name_instance["name3"]
  }
}