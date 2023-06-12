## making instance in this vpc
resource "aws_instance" "pipeline-host" {
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


connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("mumbai_keys.pem")
    host = self.public_ip
  }

  provisioner "file" {
    source = "./myrole"
    destination = "/home/ec2-user/"
  }
   provisioner "file" {
    source = "./workspace"
    destination = "/home/ec2-user/"
  }
}


## making instance in this vpc
resource "aws_instance" "pipeline-worker" {
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
              EOF
}