provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example"{
  ami = "ami-405f7226"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.example.id}"]  

  user_data = "${file("userdata.sh")}"

  tags { 
    Name ="test-terraform"
  }
}

resource "aws_security_group" "example" {
  name = "terraform-example-instance"

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }  
}
