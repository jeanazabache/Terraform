
/* ################## DATA BASE RDS - POSTGRES ##################
resource "aws_db_instance" "db-postgres" {
  provider             = aws.oregon
  allocated_storage    = 10
  identifier           = "postgresql"
  db_name              = "my_db_postgres"
  engine               = "postgres"
  engine_version       = "16.2"
  instance_class       = "db.t3.medium"
  username             = "postgres"
  password             = "password"
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.gs-oregon.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Add configuration for remote connection
  publicly_accessible = true # Allow remote access
} */

/* ################## DATA BASE RDS - mySQL ##################
resource "aws_db_instance" "db-mysql" {
  provider             = aws.oregon
  allocated_storage    = 10
  identifier           = "mysql"
  db_name              = "my_db_mysql"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.medium"
  username             = "db_mysql"
  password             = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.gs-oregon.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Add configuration for remote connection
  publicly_accessible = true # Allow remote access
} */
