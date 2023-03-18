module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "sample-cluster"  #this is the name of the cluster
  cluster_version = "1.25"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id     #uses vpc created
  subnet_ids               = module.vpc.public_subnets    #uses subnets created
  #subnet_ids               = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  #control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  
  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.large"]
  }

  eks_managed_node_groups = {
    
    green = {             #Creates Nodegroup named "green-xxxx"
      min_size     = 2
      max_size     = 2
      desired_size = 2

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

