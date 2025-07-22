data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project}/${var.environment}/vpc_id"

   
  
}



output "frontend_sg_id" {
    value = module.frontend.sg_id
  
}


output "bastion_sg_id" {
    value = module.bastion.sg_id
  
}