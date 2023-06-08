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


tags = {
    env = "Dev"
    bussines = "xxx"
  }


# Variables de entrada para creacion de la instancia EC2

ami= "ami-053b0d53c279acc90"
type_instance = "t3.small"


