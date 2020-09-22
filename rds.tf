# creating RDS in aws 
resource "aws_db_instance" "assignment_mysql" {
  allocated_storage    = 20
  max_allocation_storage = 100
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "*********"
  password             = "*********"
  parameter_group_name = "default.mysql5.7"
}
#creating securitygroup 

resource "aws_security_group" "db_22" {
  name   = "db_22"
  Description = "Allow inbound SSH traffic from my ip"
   vpc_id = "${aws_vpc.assignment_vpc.id}"

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
