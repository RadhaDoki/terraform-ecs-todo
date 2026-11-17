output "vpc_id" {
    name = ID of the crated vpc
    value = aws_vpc.my-vpc.id
}
output "EC2_public_ip"{
    name = EC2 public ip
    value = aws_instance.nginx-ece.public_ip
}
