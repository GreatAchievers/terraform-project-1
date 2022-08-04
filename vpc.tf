#my vpc provisioning
resource "aws_vpc" "OMS" {
  cidr_block       = var.OMS-vpc-cidr
  tags = local.common_tags 
  }

#my public and private subnets provisioning
resource "aws_subnet" "PublicSub" {
  vpc_id     = aws_vpc.OMS.id
  cidr_block = var.OMS-vpc-Pubsubnet-cidr
  availability_zone = var.OMS-Subnet-availability_zone_names["0"]
  map_public_ip_on_launch = true
  tags = local.common_tags
}

resource "aws_subnet" "PrivateSub" {
  vpc_id     = aws_vpc.OMS.id
  cidr_block = var.OMS-vpc-Privatesubnet-cidr
  availability_zone = var.OMS-Subnet-availability_zone_names["1"]
  map_public_ip_on_launch = false
  tags = local.common_tags
}

#My IGW resources

resource "aws_internet_gateway" "OMS-IGW" {
  vpc_id = aws_vpc.OMS.id
  tags = local.common_tags
}

#My route table resource
resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.OMS.id
  tags = local.common_tags
}
resource "aws_route_table_association" "publicAss" {
  subnet_id      = aws_subnet.PublicSub.id
  route_table_id = aws_route_table.publicRT.id
 
}

resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.OMS.id
  tags = local.common_tags
}
resource "aws_route_table_association" "privateAss" {
  subnet_id      = aws_subnet.PrivateSub.id
  route_table_id = aws_route_table.privateRT.id
  
}

#My route
resource "aws_route" "Pubroute" {
  route_table_id            = aws_route_table.publicRT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.OMS-IGW.id
  depends_on                = [aws_route_table.publicRT]
  
}


