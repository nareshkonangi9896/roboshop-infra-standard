# module "mongodb_sg" {
#     source = "../../terraform-aws-securitygroup"
#     project_name = var.project_name
#     sg_name = var.sg_name
#     sg_description = var.sg_description
#     #sg_ingress_rules = var.sg_ingress_rules
#     vpc_id = data.aws_ssm_parameter.vpc_id.value
#     comman_tags = var.comman_tags
# }
# resource "aws_security_group_rule" "mongodb" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = data.aws_ssm_parameter.vpn_sg_id.value 
#   security_group_id = module.mongodb_sg.security_group_id
# }

module "mongodb_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.devops_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id = local.db_subnet_id
  user_data = file("mongodb.sh")
  tags = merge(
    {
        Name = "mongodb"
    },
    var.comman_tags
  )
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name
  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 1
      records = [module.mongodb_instance.private_ip]
    }
  ]
}