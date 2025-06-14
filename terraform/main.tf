provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "webapp" {
  name = "webapp"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
}

resource "aws_key_pair" "assignment_key" {
  key_name   = "assignment_1"
  public_key = file("~/.ssh/assignment_1.pub")
}


resource "aws_instance" "ec2" {
  ami           = "ami-0953476d60561c955" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "assignment1-key" 
  subnet_id     = "subnet-0ac68eca994e8eeeb"         # Replace with default VPC public subnet ID
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = { Name = "Assignment1-EC2" }
}

resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-sg-"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8081
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}