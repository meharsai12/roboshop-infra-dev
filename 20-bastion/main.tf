resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = data.aws_ssm_parameter.bastion_sg_id.value

  tags = {
    Name = "HelloWorld"
  }
}