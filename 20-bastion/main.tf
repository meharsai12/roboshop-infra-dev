resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]  # the value shoule be in[] because it is consider as list in terraform
  subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

  tags = merge(local.comman_tags,
  {
    Name = "${var.project}-${var.environment}-bastion"
  }
  
  )
}