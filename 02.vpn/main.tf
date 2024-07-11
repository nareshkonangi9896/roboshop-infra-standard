# module "vpn_sg" {
#     source = "../../terraform-aws-securitygroup"
#     project_name = var.project_name
#     sg_name = var.sg_name
#     sg_description = var.sg_description
#     #sg_ingress_rules = var.sg_ingress_rules
#     vpc_id = data.aws_vpc.default.id
#     comman_tags = var.comman_tags
# }
# resource "aws_security_group_rule" "vpn" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
#   security_group_id = module.vpn_sg.security_group_id
# }

module "vpn_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.devops_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  #subnet_id = local.public_subnet[0] # public subnet in 1a az
  #user_data = file("roboshop-ansible.sh")
  tags = merge(
    {
        Name = "Roboshop-VPN"
    },
    var.comman_tags
  )
}