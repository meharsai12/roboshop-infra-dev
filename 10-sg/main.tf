module "frontend" {
    source = "../../terraform-aws-sg"
    project = var.project
    sg_name = "frontend"
    sg_description = "This is for the frontend" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}