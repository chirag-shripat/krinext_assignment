provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "vpc-for-project" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "vpc-for-project"
  }
}

## making security groups
resource "aws_security_group" "project-sg" {
    vpc_id = aws_vpc.vpc-for-project.id
    tags = {
        "Name" = "project-security-group"
    }
 
  ingress {
    description      = "inbound"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


## making both subnets

#public subnet
resource "aws_subnet" "public-subnet" {
    availability_zone = "ap-southeast-1a"
    vpc_id = aws_vpc.vpc-for-project.id
    cidr_block = "192.168.0.0/26"
    map_public_ip_on_launch = true
    
    tags = { 
        "Name" = "public-subnet"
    }
}

#private subnet one
resource "aws_subnet" "private-subnet1" {
    availability_zone = "ap-southeast-1a"
    vpc_id = aws_vpc.vpc-for-project.id
    cidr_block = "192.168.0.64/26"
    
    tags = {
        "Name" = "private-subnet1"
    }
}

#private subnet second
resource "aws_subnet" "private-subnet2" {
    availability_zone = "ap-southeast-1b"
    vpc_id = aws_vpc.vpc-for-project.id
    cidr_block = "192.168.0.128/26"
    
    tags = {
        "Name" = "private-subnet2"
    }
}

## creating IGW for "vpc-for-project" vpc
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.vpc-for-project.id

    tags = {
        "Name" = "my-igw"
    }
}

## making route tables

# public route table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc-for-project.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }
    tags = {
        "Name" = "public_rt"
    }
}

#private route table
resource "aws_route_table" "private_rt1" {
    vpc_id = aws_vpc.vpc-for-project.id

    tags = {
        "Name" = "private_rt1"
    }
}

#private route table
resource "aws_route_table" "private_rt2" {
    vpc_id = aws_vpc.vpc-for-project.id

    tags = {
        "Name" = "private_rt2"
    }
}

## associoating routing table
resource "aws_route_table_association" "route-asso-1" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "route-asso-2" {
  subnet_id = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private_rt1.id
}
resource "aws_route_table_association" "route-asso-3" {
  subnet_id = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private_rt2.id
}

resource "aws_eip" "eip" {
  instance = aws_instance.server.id
  vpc      = true
}

resource "aws_eip_association" "eip_asso" {
  instance_id = aws_instance.server.id
  allocation_id = aws_eip.eip.id
}