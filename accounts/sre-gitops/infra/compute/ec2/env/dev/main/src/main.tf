data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "node-http" {
  ami                               = data.aws_ami.amazon-linux-2.id
  instance_type                     = "t3.micro"
  iam_instance_profile              = aws_iam_instance_profile.http_nodes_dev.name
  key_name                          = "http_nodes_dev"
  subnet_id                         = var.subnet0_priv_cidr
  vpc_security_group_ids            = [aws_security_group.http-nodes-allow-access-sg.id]
  // user_data = file("./account/nodes.sh")
  

   root_block_device {
           delete_on_termination = "false" 
           encrypted             = "true"
           volume_size           = "8"
           volume_type           = "gp3"

         
  tags = {
    Name = "http-vol-nodes-dev"
    Environment      = "dev"
    Application_ID   = "ec2"
    Application_Role = "Virtual Machines for environment dev"
    Team             = "consulteanuvem-com-br-dev"
    Customer_Group   = "consulteanuvem-dev"
    Resource         = "environment_at_dev"
  }

        }

  associate_public_ip_address = true // nao associar ip publico na instancia

  tags = {
    Name = "http-nodes-dev"
    Environment      = "dev"
    Application_ID   = "ec2"
    Application_Role = "Networking for environment dev"
    Team             = "consulteanuvem-com-br-dev"
    Customer_Group   = "consulteanuvem-dev"
    Resource         = "environment_at_dev"
   
  }
}

resource "aws_security_group" "http-nodes-allow-access-sg" {
  name        = "http-nodes-allow-access-sg"
  description = "allow ssh and http nodes inbound traffic"
  vpc_id      = var.vpc_dev
  
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rule for allow access  from internal-subnet-environment"
    cidr_blocks = ["11.0.2.0/23"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rule for allow access in the http-nodes from internal-subnet-environment"
    cidr_blocks = ["11.0.4.0/23"]
  }
  
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rule for allow access in the http-nodes from internal-subnet-environment"
    cidr_blocks = ["11.0.6.0/23"]
  }

    
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rule for allow access in the http-nodes from internal-subnet-environment"
    cidr_blocks = ["11.0.8.0/23"]
  }

  
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rule for allow access in the http-nodes from internal-subnet-environment"
    cidr_blocks = ["11.0.10.0/23"]
  }

    
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rule for allow access in the http-nodes from internal-subnet-environment"
    cidr_blocks = ["11.0.12.0/23"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    description = "rule for allow output access in the http-nodes internal-subnet-environment"
    cidr_blocks     = ["0.0.0.0/0"]
  }

   tags = {
        Name = "http-nodes-dev-allow-access-sg"
        Environment      = "dev"
        Application_ID   = "vpc"
        Application_Role = "Networking for environment dev"
        Team             = "consulteanuvem-com-br-dev"
        Customer_Group   = "consulteanuvem-dev"
        Resource         = "environment_at_dev" 
       }

  
}

output "http-nodes-dev_ip_address" {
  value = aws_instance.node-http.public_dns
}
