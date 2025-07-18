data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project}/${var.environment}/vpc_id"
  
}



output "sg_id" {
    value = module.frontend.sg_id
  
}