module "auto-scaling" {
  source = "./modules/auto-scaling"

  region = "us-east-2"


  #Launch Configuration

  launch-configuration-name = "assignment-lc"
  image-id = "ami-04fcd96153cb57194"
  instance-type = "t2.micro"
  launch-configuration-security-groups = "${aws_security_group.sg_22}"
  
  #Auto-Scaling

  autoscaling-group-name = "assignment-asg"
  max-size = "4"
  min-size = "1"
  health-check-grace-period = "300"
  desired-capacity = "2"
  force-delete = "true"
  #A list of subnet IDs to launch resources in
  vpc-zone-identifier = "${module.vpc.public-subnet-ids}"
  target-group-arns = "arn:aws:elasticloadbalancing:eu-west-1:898668804275:targetgroup/cloudgeeks-tg/bbc376dff9e0dd2f"
  health-check-type = "ALB"
  tag-key = "Name"
  tag-value = "testing"

  #Auto-Scaling Policy-Scale-up
  auto-scaling-policy-name-scale-up = "cpu-policy-scale-up"
  adjustment-type-scale-up = "ChangeInCapacity"
  scaling-adjustment-scale-up = "1"
  cooldown-scale-up = "300"
  policy-type-scale-up = "SimpleScaling"

  #Auto-Scaling Policy Cloud-Watch Alarm-Scale-Up
  alarm-name-scale-up = "cpu-alarm-scale-up"
  comparison-operator-scale-up = "GreaterThanOrEqualToThreshold"
  evaluation-periods-scale-up = "2"
  metric-name-scale-up = "CPUUtilization"
  namespace-scale-up = "AWS/EC2"
  period-scale-up = "120"
  statistic-scale-up = "Average"
  threshold-scale-up = "70"

  #Auto-Scaling Policy-Scale-down
  auto-scaling-policy-name-scale-down = "cpu-policy-scale-down"
  adjustment-type-scale-down = "ChangeInCapacity"
  scaling-adjustment-scale-down = "-1"
  cooldown-scale-down = "300"
  policy-type-scale-down = "SimpleScaling"

  #Auto-Scaling Policy Cloud-Watch Alarm-Scale-down
  alarm-name-scale-down = "cpu-alarm-scale-down"
  comparison-operator-scale-down = "LessThanOrEqualToThreshold"
  evaluation-periods-scale-down = "2"
  metric-name-scale-down = "CPUUtilization"
  namespace-scale-down = "AWS/EC2"
  period-scale-down = "120"
  statistic-scale-down = "Average"
  threshold-scale-down = "50"

}
