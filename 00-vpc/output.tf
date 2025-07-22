 output "azs_zones1" {
   value = module.aws_vpc.availability_zone

} 


output "vpc_id" {
  value = module.aws_vpc.vpc_id
}


output "public_subnet_ids" {
  value = module.aws_vpc.public_subnet_ids
  
}