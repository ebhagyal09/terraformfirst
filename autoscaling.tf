## Creating Launch Configuration

resource "aws_launch_configuration" "assignment_lc" {
  image_id               = "${lookup(var.amis,var.region)}"
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.instance.id}"]
  key_name               = "${var.key_name}"
  user_data = <<-EOF
              #!/bin/bash
              wget https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.58/bin/apache-tomcat-8.5.58.tar.gz
			  tar -zvxf apache-tomcat-9.0.10.tar.gz
			  yum install wget -y
			  chmod +x startup.sh
              ./startup.sh
			                
              EOF
  lifecycle {
    create_before_destroy = true
  }
}
## Creating AutoScaling Group

resource "aws_autoscaling_group" "terraform_asg" {
  launch_configuration = "${aws_launch_configuration.terraform_asg.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_alb.terraform_asg.name}"]
  health_check_type = "ALB"
  tag {
    key = "Name"
    value = "terraform-asg-assignment"
    propagate_at_launch = true
  }
}
