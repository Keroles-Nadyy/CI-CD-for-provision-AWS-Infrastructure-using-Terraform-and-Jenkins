# resource "aws_subnet" "private_subnet_I" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.3.0/24"
#   availability_zone = "eu-west-1a"
#   tags = {
#     Name = "Cloud_PD44_Private_subnet_I"
#   }
# }

# resource "aws_subnet" "private_subnet_II" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.4.0/24"
#   availability_zone = "eu-west-1b"
#   tags = {
#     Name = "Cloud_PD44_Private_subnet_II"
#   }
# }