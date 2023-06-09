resource "aws_security_group" "rds_sg" {
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "rds-sg"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "privat-subnet"
  subnet_ids = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]

  tags = {
    Name = "DB_subnet"
  }
}

resource "aws_db_instance" "mydb" {
  identifier           = "my-database"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
  db_name              = "dhanesh"
  username             = "admin"
  password             = "xnux9617?"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "my-database"
  }
}