[200~provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA3OMUFFP2IVJSXRSN"
  secret_key = "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"
}
#create vpc for 3 tier architecture design 

resource "aws_vpc" "3tierarchivpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true 

  tags = {
  Name = "3tierarchivpc"
  }
 }
 
 #creating internet gateway and attaching to vpc  3tierarchi
resource "aws_internet_gateway" "igw"{
  vpc_id = "${aws_vpc.3tierarchivpc.id}"

  tags = {
  Name = "igw"
 }
}


# Creation of public subnets
resource "aws_subnet" "public1" {
  vpc_id   = "${aws_vpc.3tierarchivpc.id}"
  cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
	map_public_ip_on_launch = "true"
	
  tags = {
  Name = " public-subnet-1"
  }
 }
 
 resource "aws_subnet" "public2" {
  vpc_id   = "${aws_vpc.3tierarchivpc.id}"
  cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-2b"
	map_public_ip_on_launch = "true"
	
  tags = {
  Name = " public-subnet-2"
  }
 }
 #creation of route table
 
 resource "aws_route_table" "public1" {
    vpc_id = "${aws_vpc.3tierarchivpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = {
        Name = "Public-Subnet-1"
    }
}

resource "aws_route_table_association" "public1" {
    subnet_id      = "${aws_subnet.public1.id}"
    route_table_id = "${aws_route_table.public1.id}"
}
resource "aws_route_table_association" "public2" {
    subnet_id      = "${aws_subnet.public2.id}"
    route_table_id = "${aws_route_table.public1.id}"
}
 
 # creating private subnets 
 
	resource "aws_subnet" "private1" {
  vpc_id   = "${aws_vpc.3tierarchivpc.id}"
  cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-2a"
	map_public_ip_on_launch = "true"
	
  tags = {
  Name = " private-subnet-1"
  }
 }
 
 resource "aws_subnet" "private2" {
  vpc_id   = "${aws_vpc.3tierarchivpc.id}"
  cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-2b"
	map_public_ip_on_launch = "true"
	
  tags = {
  Name = " private-subnet-2"
  }
 }
 
 # creating route table for private subnet 
 
 resource "aws_route_table" "private1" {
    vpc_id = "${aws_vpc.3tierarchivpc.id}"
    
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.igw.id}"
    }

    tags = {
        Name = "Private-Subnet-1"
    }
}

resource "aws_route_table_association" "private1" {
    subnet_id      = "${aws_subnet.private1.id}"
    route_table_id = "${aws_route_table.private1.id}"
}
resource "aws_route_table_association" "private2" {
    subnet_id      = "${aws_subnet.private2.id}"
    route_table_id = "${aws_route_table.private1.id}"
}

# creating NAT gateway 

resource aws_eip" "nat" {
  vpc = true 
  }
resource "aws_nat_gateway" "ngw" {
 allocation_id = "${aws_eip.nat.id}"
 subnet_id     = "${aws_subnet.public1.id}"
 
 tags = {
  Name = "natgw"
  }
}


 
 
 

