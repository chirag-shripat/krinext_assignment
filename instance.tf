## making instance in this vpc
resource "aws_instance" "ansible-host" {
    ami = "ami-03cb1380eec7cc118"
    instance_type = "t2.micro"
    key_name = "mumbai_keys"
    availability_zone = "ap-south-1a"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.project-sg.id]

    tags = { 
        "Name" = "ansible_host"
    }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install ansible2 -y
              sudo yum install -y mysql
              EOF
}


## making instance in this vpc
resource "aws_instance" "ansible-slave" {
    ami = "ami-03cb1380eec7cc118"
    instance_type = "t2.micro"
    key_name = "mumbai_keys"
    availability_zone = "ap-south-1a"
    subnet_id = aws_subnet.public-subnet.id
    vpc_security_group_ids = [aws_security_group.project-sg.id]

    tags = { 
        "Name" = "ansible_slave"
    }
  user_data = <<-EOF
             #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install ansible2 -y
              sudo yum install -y mysql
              EOF
}