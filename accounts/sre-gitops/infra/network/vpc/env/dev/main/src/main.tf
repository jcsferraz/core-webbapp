resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_blocks
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags ={
      Name             = "vpc-dev"
      Environment      = "dev"
      Application_ID   = "vpc"
      Application_Role = "Networking for environment dev"
      Team             = "consulteanuvem-com-br-dev"
      Customer_Group   = "consulteanuvem-dev"
      Resource         = "environment_at_dev" 
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
         Name             = "igw-pub-dev"
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
          Name             = "route-pub-dev"
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
  subnet_id      = var.subnet0_pub_cidr
  route_table_id = aws_route_table.rtb_public.id
}



resource "aws_eip" "eip_nat_gateway" {
  vpc = true
    tags = {
         Name             = "eip-nat-prv-dev"
         Environment      = "dev"
         Application_ID   = "vpc"
         Application_Role = "Networking for environment dev"
         Team             = "consulteanuvem-com-br-dev"
         Customer_Group   = "consulteanuvem-dev"
         Resource         = "environment_at_dev"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  // connectivity_type    = "public"
  allocation_id          = aws_eip.eip_nat_gateway.id
  subnet_id              = var.subnet0_pub_cidr
  tags = {
         Name             = "nat-prv-dev"
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
          Name             = "route-prv-dev"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev" 
  }
}

resource "aws_route_table_association" "nat_gateway" {
  subnet_id      = var.subnet0_priv_cidr
  route_table_id = aws_route_table.nat_gateway.id
}

resource "aws_subnet" "subnet-dev-a-pub" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet0_pub_cidr}"
  availability_zone       = "us-east-1a"
  tags = {
          Name             = "subnet-dev-a-pub"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev"
  }
}

resource "aws_subnet" "subnet-dev-b-pub" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet1_pub_cidr}"
  availability_zone       = "us-east-1b"
  tags = {
          Name             = "subnet-dev-b-pub"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev"
  }
}

resource "aws_subnet" "subnet-dev-c-pub" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet2_pub_cidr}"
  availability_zone = "us-east-1c"
  tags = {
          Name = "subnet-dev-c-pub"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev"
  }
}

resource "aws_subnet" "subnet-dev-a-priv" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet0_priv_cidr}"
  availability_zone = "us-east-1a"
  tags = {
          Name = "subnet-dev-a-priv"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev"
  }
}

resource "aws_subnet" "subnet-dev-b-priv" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet1_priv_cidr}"
  availability_zone       = "us-east-1b"
  tags = {
          Name = "subnet-dev-b-priv"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev"
  }
}

resource "aws_subnet" "subnet-dev-c-priv" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet2_priv_cidr}"
  availability_zone       = "us-east-1c"
  tags = {
          Name             = "subnet-dev-c-priv"
          Environment      = "dev"
          Application_ID   = "vpc"
          Application_Role = "Networking for environment dev"
          Team             = "consulteanuvem-com-br-dev"
          Customer_Group   = "consulteanuvem-dev"
          Resource         = "environment_at_dev"
  }
}
