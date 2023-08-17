module "network_vpc_dev" {
  source  = "./accounts/sre-gitops/infra/network/vpc/env/dev/main/src"
  vpc_cidr_block           = var.vpc_cidr_block_dev
  cidr_blocks              = var.cidr_blocks
  secondary_vpc_cidr_block = var.secondary_vpc_cidr_block_dev
  public_subnets = [
    { cidr_blocks = "11.0.2.0/23", zone = "us-east-1a", name = "subnet-dev-a-pub" },
    { cidr_blocks = "11.0.4.0/23", zone = "us-east-1b", name = "subnet-dev-b-pub" },
    { cidr_blocks = "11.0.6.0/23", zone = "us-east-1c", name = "subnet-dev-c-pub" },
    { cidr_blocks = "12.0.2.0/23", zone = "us-east-1d", name = "subnet-dev-d-pub" },
    { cidr_blocks = "12.0.4.0/23", zone = "us-east-1e", name = "subnet-dev-e-pub" },
    { cidr_blocks = "12.0.6.0/23", zone = "us-east-1f", name = "subnet-dev-f-pub" }
  ]

  private_subnets = [
    { cidr_blocks = "11.0.8.0/23",  zone = "us-east-1a", name = "subnet-dev-a-priv" },
    { cidr_blocks = "11.0.10.0/23", zone = "us-east-1b", name = "subnet-dev-b-priv" },
    { cidr_blocks = "11.0.12.0/23", zone = "us-east-1c", name = "subnet-dev-c-priv" },
    { cidr_blocks = "12.0.8.0/23",  zone = "us-east-1d", name = "subnet-dev-d-priv" },
    { cidr_blocks = "12.0.10.0/23", zone = "us-east-1e", name = "subnet-dev-e-priv" },
    { cidr_blocks = "12.0.12.0/23", zone = "us-east-1f", name = "subnet-dev-f-priv" }
  ]
}


module "dynamodb_global_tables_dev" {
 source  = "./accounts/sre-gitops/infra/data-store/dynamodb/env/dev/main/src"
}


module "http_nodes_dev" {
 source  = "./accounts/sre-gitops/infra/compute/ec2/env/dev/main/src"
  vpc  = var.vpc_dev
  vpc_cidr_block = var.vpc_cidr_block_dev
  cidr_blocks    = var.cidr_blocks
  private_subnets = var.private_subnets_dev
  public_subnets  = var.public_subnets_dev
}
