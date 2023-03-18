module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
 version="3.19.0"     
name = "eksvpc"
  cidr = "10.0.0.0/16" #follow cidr block rules
azs             = ["us-east-1a", "us-east-1b"] #most be more than (1) avalabilty zone to work
    public_subnets  = ["10.0.101.0/24", "10.0.105.0/24"]
    
enable_nat_gateway = false
  enable_vpn_gateway = false

tags = {
    Name = "EKSVPC"
    Terraform = "true"
    Environment = "dev"
  }
}
