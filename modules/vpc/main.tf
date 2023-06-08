resource "aws_vpc" "base_vpc1" {
  cidr_block       = var.range_vpc
  instance_tenancy = "default"

  tags = var.tags_vpc
}

# Create a public subnet1
resource "aws_subnet" "PublicSubnet1"{
    vpc_id = aws_vpc.base_vpc1.id
    availability_zone = var.availability_zone_public1
    cidr_block = var.cidr_subnet_public1

    tags = var.tags_public_subnet1
}


# Create a public subnet2
resource "aws_subnet" "PublicSubnet2"{
    vpc_id = aws_vpc.base_vpc1.id
    availability_zone = var.availability_zone_public2
    cidr_block = var.cidr_subnet_public2

    tags = var.tags_public_subnet2
}



 # create a private subnet1
resource "aws_subnet" "PrivSubnet1"{
    vpc_id = aws_vpc.base_vpc1.id
    cidr_block = var.cidr_subnet_private1
    map_public_ip_on_launch = true
    availability_zone = var.availability_zone_private1

    tags = var.tags_private_subnet1

}

 # create a private subnet2
resource "aws_subnet" "PrivSubnet2"{
    vpc_id = aws_vpc.base_vpc1.id
    cidr_block = var.cidr_subnet_private2
    map_public_ip_on_launch = true
    availability_zone = var.availability_zone_private2

    tags = var.tags_private_subnet2

}


 # create IGW
resource "aws_internet_gateway" "base_Igw"{
    vpc_id = aws_vpc.base_vpc1.id
}

 # : route Tables for public subnet
resource "aws_route_table" "PublicRT"{
    vpc_id = aws_vpc.base_vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.base_Igw.id
    }

    
}
 

 # route table association public subnet 1
resource "aws_route_table_association" "PublicRTAssociation"{
    subnet_id = aws_subnet.PublicSubnet1.id
    route_table_id = aws_route_table.PublicRT.id
}

 # route table association public subnet 2

resource "aws_route_table_association" "PublicRTAssociation1"{
    subnet_id = aws_subnet.PublicSubnet2.id
    route_table_id = aws_route_table.PublicRT.id
}


resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.PublicSubnet1.id
  tags = {
    "Name" = "nat_gateway"
  }
}

output "nat_gateway_ip" {
  value = aws_eip.nat_gateway.public_ip
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.base_vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "PrivateRTAssociation" {
  subnet_id = aws_subnet.PrivSubnet1.id
  route_table_id = aws_route_table.PrivateRT.id
}


resource "aws_route_table_association" "PrivateRTAssociation1" {
  subnet_id = aws_subnet.PrivSubnet2.id
  route_table_id = aws_route_table.PrivateRT.id
}