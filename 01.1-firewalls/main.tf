module "vpn_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "vpn"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_vpc.default.id
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "VPN",
            Name = "roboshop-VPN"
        }
    )
}
module "mongodb_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "mongodb"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "MongoDB",
            Name = "MongoDB"
        }
    )
}
module "catalogue_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "catalogue"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Catalogue",
            Name = "Catalogue"
        }
    )
}
module "web_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "web"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Web",
            Name = "Web"
        }
    )
}
module "app_alb_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "App-ALB"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "App",
            Name = "App-ALB"
        }
    )
}
module "web_alb_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "Web-ALB"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Web",
            Name = "Web-ALB"
        }
    )
}
resource "aws_security_group_rule" "vpn" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  security_group_id = module.vpn_sg.security_group_id
}
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  description       = "Allowing port number 27017 from catalogue"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue_sg.security_group_id
  security_group_id = module.mongodb_sg.security_group_id
}
resource "aws_security_group_rule" "mongodb_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.mongodb_sg.security_group_id
}
resource "aws_security_group_rule" "catalogue_app_alb" {
  type              = "ingress"
  description       = "Allowing port number 8080 from app_alb"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id = module.catalogue_sg.security_group_id
}
resource "aws_security_group_rule" "catalogue_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.catalogue_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  description       = "Allowing port number 80 from vpn"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_web" {
  type              = "ingress"
  description       = "Allowing port number 80 from web"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_sg.security_group_id
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "web_web_alb" {
  type              = "ingress"
  description       = "Allowing port number 80 from web_alb"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.security_group_id
  security_group_id = module.web_sg.security_group_id
}

# resource "aws_security_group_rule" "web_vpn" {
#   type              = "ingress"
#   description       = "Allowing port number 22 from vpn"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.vpn_sg.security_group_id
#   security_group_id = module.web_sg.security_group_id
# }
resource "aws_security_group_rule" "web_vpn" {
  type              = "ingress"
  description       = "Allowing port number 80 from vpn"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.web_sg.security_group_id
}

resource "aws_security_group_rule" "web_alb_internet_80" {
  type              = "ingress"
  description       = "Allowing port number 80 from internet"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
# source_security_group_id = module.vpn_sg.security_group_id
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.web_alb_sg.security_group_id
}
resource "aws_security_group_rule" "web_alb_internet_443" {
  type              = "ingress"
  description       = "Allowing port number 443 from internet"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
# source_security_group_id = module.vpn_sg.security_group_id
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = module.web_alb_sg.security_group_id
}