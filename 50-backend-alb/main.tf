module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  internal = true # default will be false so it will be public ,if internal = true it will become private load balancer
  name    = "${var.project}-${var.environment}-backend-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  enable_deletion_protection = false

  # Security Group
  create_security_group = false # i have given security create is false because i am already created security group in 10-sg for backend alb
  security_groups = [data.aws_ssm_parameter.backend_alb_sg.value] # instaed of creating security group i have creadted separate security i called it throuh data sources by save sg id in awss sssm parameter and recalled it here

  
 
  tags = merge(
    local.comman_tags,
    {
        Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}



resource "aws_lb_listener" "backend_alb_lis" {
  depends_on = [module.backend_alb]
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> I am rom the backend team doing alb testing</h1>"
      status_code  = "200"
    }
  }
}