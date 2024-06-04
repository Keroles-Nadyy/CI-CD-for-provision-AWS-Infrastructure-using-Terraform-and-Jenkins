# resource "aws_subnet" "public_subnet_I" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "eu-west-1a"
#   tags = {
#     Name = "Cloud_PD44_Public_subnet_I"
#   }
# }

# resource "aws_subnet" "public_subnet_II" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "eu-west-1b"
#   tags = {
#     Name = "Cloud_PD44_Public_subnet_II"
#   }

# }