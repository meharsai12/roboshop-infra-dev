data "aws_ami" "ami" {
  owners           = ["010928200701"]
  most_recent      = true

  filter {
    name   = "name"
    values = ["AutoscalinggroupAMI"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value       = data.aws_ami.ami.id
}


data "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project}/${var.environment}/bastion_sg_id"
}