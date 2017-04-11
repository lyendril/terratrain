provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "www"{
  ami = "ami-405f7226"
  instance_type = "t2.micro"

  tags { 
    Name ="test-terraform"
  }
	     
}

