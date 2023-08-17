module "network_vpc_dev" {
  source  = "./accounts/sre-gitops/infra/network/vpc/env/dev/main/src"
  vpc_dev                       = var.vpc_dev
  cidr_blocks                   = var.cidr_blocks
  subnet0_pub_cidr              = var.subnet0_pub_cidr
  subnet1_pub_cidr              = var.subnet1_pub_cidr
  subnet2_pub_cidr              = var.subnet2_pub_cidr
  subnet0_priv_cidr             = var.subnet0_priv_cidr
  subnet1_priv_cidr             = var.subnet1_priv_cidr
  subnet2_priv_cidr             = var.subnet2_priv_cidr
}

module "dynamodb_global_tables_dev" {
 source  = "./accounts/sre-gitops/infra/data-store/dynamodb/env/dev/main/src"
}


module "http_nodes_dev" {
 source  = "./accounts/sre-gitops/infra/compute/ec2/env/dev/main/src"
  vpc_dev                       = var.vpc_dev
  cidr_blocks                   = var.cidr_blocks
  subnet0_pub_cidr              = var.subnet0_pub_cidr
  subnet1_pub_cidr              = var.subnet1_pub_cidr
  subnet2_pub_cidr              = var.subnet2_pub_cidr
  subnet0_priv_cidr             = var.subnet0_priv_cidr
  subnet1_priv_cidr             = var.subnet1_priv_cidr
  subnet2_priv_cidr             = var.subnet2_priv_cidr
} 
