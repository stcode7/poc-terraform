output "subnet_private" {
  value       = aws_subnet.PrivSubnet1.id
  description = "identificador subnet privada 1"
}

output "cidr_vpc_base" {
  value       = aws_vpc.base_vpc1.id
  description = "identificador subnet privada 1"
}