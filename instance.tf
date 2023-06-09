## making instance in this vpc
resource "aws_instance" "server" {
    ami = "ami-063e1495af50e6fd5"
    instance_type = "t2.micro"
    key_name = "singapore_keys"
    availability_zone = "ap-southeast-1a"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.project-sg.id]

    tags = { 
        "Name" = "server"
    }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker run -dit --name wordpress -p 80:80 wordpress
              sudo yum install -y mysql
              EOF
}