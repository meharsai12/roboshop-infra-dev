module "frontend" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/meharsai12/terraform-aws-sg.git?ref=main"
    project = var.project
    sg_name = "frontend"
    sg_description = "This is for the frontend" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}



module "bastion" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/meharsai12/terraform-aws-sg.git?ref=main"
    project = var.project
    sg_name = "bastion"
    sg_description = "This is for the bastion" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}


resource "aws_security_group_rule" "bastion_mylaptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}