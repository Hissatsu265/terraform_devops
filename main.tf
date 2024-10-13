module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}
module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = module.vpc.public_subnet_id
  private_subnet_id   = module.vpc.private_subnet_id
  internet_gateway_id = module.vpc.igw_id
  nat_gateway_id      = module.vpc.natgw_id
}
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  my_ip  = "42.114.200.163/32" 
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-005fc0f236362e99f"
  instance_type      = "t2.micro"
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  public_sg_id       = module.security_groups.public_sg_id
  private_sg_id      = module.security_groups.private_sg_id
  key_pair           = "g16"
}
