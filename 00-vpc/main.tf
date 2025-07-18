module "aws_vpc" {

  source             = "git::https://github.com/meharsai12/aws-vpc-module.git?ref=main"
  project            = var.project
  environment        = var.environment
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr

is_peering_required = true  

}



output "vpc_id" {
  value = module.aws_vpc.vpc_id
}