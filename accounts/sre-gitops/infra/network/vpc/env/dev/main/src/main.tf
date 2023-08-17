resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags ={
      Name="vpc-dev"
      Environment      = "dev"
      Application_ID   = "vpc"
      Application_Role = "Networking for environment dev"
      Team             = "consulteanuvem-com-br-dev"
      Customer_Group   = "consulteanuvem-dev"
      Resource         = "environment_at_dev" 
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_vpc_cidr" {
  vpc_id      = aws_vpc.vpc.id
  cidr_block  = var.secondary_vpc_cidr_block
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
         Name ="igw-pub-dev"
         Environment      = "dev"
         Application_ID   = "vpc"
         Application_Role = "Networking for environment dev"
         Team             = "consulteanuvem-com-br-dev"
         Customer_Group   = "consulteanuvem-dev"
         Resource         = "environment_at_dev" 
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  tags =  {
          Name ="route-pub-dev"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev" 
  }
}

resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.rtb_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rtb_associations_public" {
  for_each       = { for subnet in var.public_subnets_dev : subnet.name => subnet }
  subnet_id      = aws_subnet.public_subnets[each.value.name].id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_subnet" "public_subnets" {
  for_each                = { for subnet in var.public_subnets_dev : subnet.name => subnet }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.zone
  map_public_ip_on_launch = true
  cidr_block              = each.value.cidr_blocks
  tags =  {
          Name ="${each.key}"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev" 
  }
}

resource "aws_eip" "eip_nat_gateway" {
  vpc = true
    tags = {
         Name ="eip-nat-prv-dev"
         Environment      = "dev"
         Application_ID   = "vpc"
         Application_Role = "Networking for environment dev"
         Team             = "consulteanuvem-com-br-dev"
         Customer_Group   = "consulteanuvem-dev"
         Resource         = "environment_at_dev"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type    = "public"
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id  = aws_subnet.public_subnets[element(keys(aws_subnet.public_subnets), 0)].id
  tags = {
         Name ="nat-prv-dev"
         Environment      = "dev"
         Application_ID   = "vpc"
         Application_Role = "Networking for environment dev"
         Team             = "consulteanuvem-com-br-dev"
         Customer_Group   = "consulteanuvem-dev"
         Resource         = "environment_at_dev" 
  }
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags =  {
          Name ="route-prv-dev"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev" 
  }
}

resource "aws_route_table_association" "nat_gateway" {
  for_each       = { for subnet in var.private_subnets_dev : subnet.name => subnet }
  subnet_id      = aws_subnet.private_subnets[each.value.name].id
  route_table_id = aws_route_table.nat_gateway.id
}
  
resource "aws_subnet" "private_subnets" {
  for_each                = { for subnet in var.private_subnets_dev : subnet.name => subnet }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.zone
  map_public_ip_on_launch = false
  cidr_block              = each.value.cidr_blocks
  tags =  {
          Name ="${each.key}"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev" 
  }
}