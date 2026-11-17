resource "aws_region"{
    type = "string"
    default = ap-south-2
}
resource "aws_vpc","my-vpc{
    name = aws_vpc.my-vpc.id
    type = "string"
    CIDR = 10.0.0.0/16

}
resource "aws_subnet","public-sub" {
    name = aws_subnet.public-sub.id
    type = "string"
    CIDR = 10.0.1.0/24

|}
