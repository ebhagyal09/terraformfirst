#creating securitygroup
#Allow inbound SSH traffic from my ip

resource "aws_security_group" "sg_22" {
  name   = "sg_22"
  Description = "Allow inbound SSH traffic from my ip"
   vpc_id = "${aws_vpc.3tierarchivpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags {
  Name = "Allow SSH"
  }
 }
  ingress {
    from_port   = 80
    to_port     = 80
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
