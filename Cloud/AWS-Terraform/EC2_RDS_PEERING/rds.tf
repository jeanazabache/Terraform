################## DATA BASE RDS - POSTGRES ##################
/* resource "aws_db_instance" "db-postgres" {
  provider             = aws.oregon
  allocated_storage    = 10
  identifier           = "postgresql"
  db_name              = "db_postgres"
  engine               = "postgres"
  engine_version       = "16.2"
  instance_class       = "db.t3.medium"
  username             = "user_postgres"
  password             = var.password
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.gs-oregon.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Add configuration for remote connection
  publicly_accessible = true # Allow remote access
} */ 

################## DATA BASE RDS - mySQL ##################
resource "aws_db_instance" "db-mysql" {
  provider             = aws.oregon
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

  db_subnet_group_name   = aws_db_subnet_group.gs-oregon.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Add configuration for remote connection
  publicly_accessible = false # Allow remote access
}
