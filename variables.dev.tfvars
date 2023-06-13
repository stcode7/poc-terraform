# Variables de entrada para creacion de la vpc

range_vpc = "10.0.0.0/16"
cidr_subnet_public1 = "10.0.1.0/24"
cidr_subnet_public2 = "10.0.2.0/24"
cidr_subnet_private1 = "10.0.3.0/24"
cidr_subnet_private2 = "10.0.4.0/24"

availability_zone_public1 = "us-east-1a"
availability_zone_public2 = "us-east-1b"
availability_zone_private1 = "us-east-1a"
availability_zone_private2 = "us-east-1b"



tags_vpc = {
    Name = "vpc_base"
    Entorno = "Desarrollo"
  }

tags_ec2 = {
    Name = "ec2_base2"
    Entorno = "Desarrollo2"
  }

tags_public_subnet1 = {
    Name = "Subnet_Public1"
    Entorno = "Desarrollo"
  }


tags_public_subnet2 = {
    Name = "Subnet_Public2"
    Entorno = "Desarrollo"
  }

tags_private_subnet1 = {
    Name = "Subnet_private1"
    Entorno = "Desarrollo"
  }


tags_private_subnet2 = {
    Name = "Subnet_private2"
    Entorno = "Desarrollo"
  }

# Variables de entrada para creacion de la instancia EC2

ami= "ami-0715c1897453cabd1"
type_instance = "t3.small"
volume_size = "10"
volume_type = "gp2"

