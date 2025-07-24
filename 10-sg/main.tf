module "frontend" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/meharsai12/terraform-aws-sg.git?ref=main"
    project = var.project
    sg_name = "frontend"
    sg_description = "This is for the frontend" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}

# mbastion sg will be craeted know as jump host aka bastion for connecting private instances through ssh 

module "bastion" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/meharsai12/terraform-aws-sg.git?ref=main"
    project = var.project
    sg_name = "bastion"
    sg_description = "This is for the bastion" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}

#this is the rules for bastion server from my laptop
resource "aws_security_group_rule" "bastion_mylaptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}


# this is for backend alb on port no 80
module "backend-alb-sg" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/meharsai12/terraform-aws-sg.git?ref=main"
    project = var.project
    sg_name = "backend-alb-sg"
    sg_description = "This is for the backend-alb" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}


#this is rules for backend application load balancer rules and adding bastion sg id for accepting connection through bastion server
resource "aws_security_group_rule" "backend-alb-sg-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id   # instead of  adding ip address , We will be adding bastion sg_id so the bastion can access it in private 
  security_group_id = module.backend-alb-sg.sg_id
}

module "vpn" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/meharsai12/terraform-aws-sg.git?ref=main"
    project = var.project
    sg_name = "vpn"
    sg_description = "This is for the vpn" 
    environment = var.environment
    vpc_id = data.aws_ssm_parameter.vpc_id.value

}


 resource "aws_security_group_rule" "vpn_ssh" {
   type              = "ingress"
   from_port         = 22
   to_port           = 22
   protocol          = "tcp"
   cidr_blocks =   ["0.0.0.0/0"]   # instead of  adding ip address , We will be adding bastion sg_id so the bastion can access it in private 
   security_group_id = module.vpn.sg_id
 }


 resource "aws_security_group_rule" "vpn_https" {
   type              = "ingress"
   from_port         = 443
   to_port           = 443
   protocol          = "tcp"
   cidr_blocks =   ["0.0.0.0/0"]   # instead of  adding ip address , We will be adding bastion sg_id so the bastion can access it in private 
   security_group_id = module.vpn.sg_id
 }



 resource "aws_security_group_rule" "vpn_1194" {
   type              = "ingress"
   from_port         = 1194
   to_port           = 1194
   protocol          = "tcp"
   cidr_blocks =   ["0.0.0.0/0"]   # instead of  adding ip address , We will be adding bastion sg_id so the bastion can access it in private 
   security_group_id = module.vpn.sg_id
 }


 resource "aws_security_group_rule" "vpn_943" {
   type              = "ingress"
   from_port         = 943
   to_port           = 943
   protocol          = "tcp"
   cidr_blocks =   ["0.0.0.0/0"]   # instead of  adding ip address , We will be adding bastion sg_id so the bastion can access it in private 
   security_group_id = module.vpn.sg_id
 }

