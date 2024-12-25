################## DATA BASE RDS - mySQL ##################
resource "aws_db_instance" "db-mysql" {
  provider = aws.virginia
  allocated_storage    = 10
  identifier           = "mysql"
  db_name              = "db_mysql"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.medium"
  username             = "user_mysql"
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.gs-virginia.id
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Add configuration for remote connection
  publicly_accessible = false # Allow remote access
}