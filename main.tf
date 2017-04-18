provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example"{
  ami                    = "ami-405f7226"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.toto.id}"]  

  user_data = "${file("userdata.sh")}"

  tags { 
    Name ="test-terraform"
  }
}

resource "aws_security_group" "toto" {
  name = "terraform-toto-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }  
    
    lifecycle {
      create_before_destroy = true
    }
}
resource "aws_launch_configuration" "toto" { 
  image_id             = "ami-405f7226"
  instance_type        = "t2.micro"
  security_groups      = ["${aws_security_group.toto.id}"]

}

resource "aws_autoscaling_group" "toto" {
  launch_configuration = "${aws_launch_configuration.toto.id}"

  min_size = "${var.min_asg}"
  max_size = "${var.max_asg}"

  tag { 
    key			= "Name"
    value		= "terraform-asg-toto"
    propagate_at_launch = "true"
  }
}

resource "aws_vpc" "toto"{
  cidr_block = "10.0.0.0/16"

   tags {
     Name = "main"
   }
}
