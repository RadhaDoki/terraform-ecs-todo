variable "aws_region"{
    type = "string"
    default = ap-south-2
}
variable "vpc_cidr" {
    description = vpc cidr block
    type = "string"
    cidr_block = 10.0.0.0/16

}
variable "public_subnet_cidr"{
    name = public subnet cidr
    type = "string"
    cidr_block = 10.0.1.0/24
}
variable "availability_zone" {
    name = availability zone for ec2 deployment
    type = "string"
    default = "ap-south-2a"
}
variable "instance_type" {
    name = instance type for ec2
    type = "string"
    default = "t3.micro"
}
variable "my_ip" {
    type = string
}