module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true # default will be false so it will be public ,if internal = true it will become private load balancer
  name    = "${var.project}-${var.environment}-backend-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  # Security Group
  create_security_group = false # i have given security create is false because i am already created security group in 10-sg for backend alb
  security_groups = [data.aws_ssm_parameter.backend-alb-sg.sg_id.value] # instaed of creating security group i have creadted separate security i called it throuh data sources by save sg id in awss sssm parameter and recalled it here

  
 
  tags = merge(
    local.comman_tags,
    {
        Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}