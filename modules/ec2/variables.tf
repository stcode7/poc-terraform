variable "ami" {
  description = "cidr de la vpc"
  type        = string
}

variable "private_subnet" {
  type        = string
  description = "identificador subnet"
}

variable tags_ec2 {
    type = map(string)
}


variable "volume_size" {
  description = "cidr para la subnet publica 2"
  type        = string
}


variable "volume_type" {
  description = "cidr para la subnet publica 2"
  type        = string
}



variable "type_instance" {
  description = "cidr para la subnet publica 2"
  type        = string
}


variable "cidr_vpc_base" {
  type        = string
  description = "identificador subnet"
}




