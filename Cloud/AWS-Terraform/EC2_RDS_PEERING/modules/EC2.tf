


/* resource "aws_instance" "web_server" {
  provider = aws.virginia
  ami             = "ami-04b70fa74e45c3917"  # ID de la AMI de Ubuntu
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  key_name        = var.keypair_virginia
  subnet_id       = aws_subnet.subnet_1_virginia.id
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]

  tags = {
    Name = var.instance_name
  }
}
*/




/* resource "aws_instance" "instance_oregon" {
  provider = aws.oregon
  ami             = "ami-01175fe07368af8c6"  # ID de la AMI de Windows Server 2012
  instance_type   = "t3.medium"
  associate_public_ip_address = true # IP Pública
  subnet_id       = aws_subnet.subnet_1_oregon.id
  key_name        = var.keypair_oregon
  vpc_security_group_ids = [ aws_security_group.windows_server_sg.id ]
} */

