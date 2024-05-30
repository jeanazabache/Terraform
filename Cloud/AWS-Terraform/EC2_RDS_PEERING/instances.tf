################## EC2 - UBUNTU ##################
resource "aws_instance" "web_server" {
  provider = aws.virginia
  ami             = var.instance_amis["instance1"] # ID de la AMI de Ubuntu
  instance_type   = var.type_instance
  associate_public_ip_address = true # IP Pública
  key_name        = var.keypairs["keypair1"]
  subnet_id       = aws_subnet.subnet_1_virginia.id
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]

  tags = {
    Name = var.name_instance["name1"]
  }
}

################## EC2 - WINDOWS SERVER - Orregon ##################
resource "aws_instance" "windows_server_oregon" {
  provider = aws.oregon
  ami             = var.instance_amis["instance2"]  # ID de la AMI de Windows Server 2012
  instance_type   = var.type_instance
  associate_public_ip_address = true # IP Pública
  subnet_id       = aws_subnet.subnet_1_oregon.id
  key_name        = var.keypairs["keypair2"]
  vpc_security_group_ids = [ aws_security_group.windows_server_sg.id ]
  tags = {
    Name =  var.name_instance["name2"]
  }
}

