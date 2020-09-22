variable "aws_region" {
  default = "us-east-2"
}

variable "aws_profile" {
  default = "default"
}
  variable "count" {
  default = "1"
}

variable "availability_zone" {
  type    = list(string)
  default = ["us-east-2a","us-east-2b"]
}

variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS."
  default = "/home/ec2-user/developments/devops/keyfile/terraform1.pem"
}
variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "terraform1"
}
variable "amis" {
  description = "Base AMI to launch the instances"
  default = {
  ap-south-1 = "ami-04fcd96153cb57194"
  }
}
