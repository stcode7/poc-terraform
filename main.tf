module "aws_vpc" {
  source = "./modules/vpc"

  range_vpc = var.range_vpc
  cidr_subnet_public1 = var.cidr_subnet_public1
  cidr_subnet_public2 = var.cidr_subnet_public2
  cidr_subnet_private1 =  var.cidr_subnet_private1
  cidr_subnet_private2 =  var.cidr_subnet_private2
  availability_zone_public1 = var.availability_zone_public1
  availability_zone_public2 =  var.availability_zone_public2
  availability_zone_private1 = var.availability_zone_private1
  availability_zone_private2 =  var.availability_zone_private2
  tags_vpc = var.tags_vpc
  tags_public_subnet1 = var.tags_public_subnet1
  tags_public_subnet2 = var.tags_public_subnet2 
  tags_private_subnet1 = var.tags_private_subnet1
  tags_private_subnet2  = var.tags_private_subnet2 
}


module "aws_ec2" {
  source = "./modules/ec2"

 ami = var.ami
 private_subnet = module.aws_vpc.subnet_private
 type_instance = var.type_instance
 cidr_vpc_base = module.aws_vpc.cidr_vpc_base
 volume_size = var.volume_size
 volume_type = var.volume_type
 tags_ec2 = var.tags_ec2

 
}