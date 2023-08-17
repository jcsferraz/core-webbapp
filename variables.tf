variable "aws_region" {
    description = "the aws region"
    default = "us-east-1"
  
}

variable "vpc_dev" {
  description = "The top-level VPC."
  default     = "vpc-dev"
}

variable "cidr_blocks" {
  description = "CIDR Block From VPC"
  default = "11.0.0.0/16"
}

# Defining CIDR Block Public for 1st Subnet
variable "subnet0_pub_cidr" {
  default = "11.0.2.0/23"
}
# Defining CIDR Block Public for 2nd Subnet
variable "subnet1_pub_cidr" {
  default = "11.0.4.0/23"
}
# Defining CIDR Block Public for 3rd Subnet
variable "subnet2_pub_cidr" {
  default = "11.0.6.0/23"
}

# Defining CIDR Block Private for 1st Subnet
variable "subnet0_priv_cidr" {
  default = "11.0.8.0/23"
}
# Defining CIDR Block Private for 2nd Subnet
variable "subnet1_priv_cidr" {
  default = "11.0.10.0/23"
}
# Defining CIDR Block Private for 3rd Subnet
variable "subnet2_priv_cidr" {
  default = "11.0.12.0/23"
}
