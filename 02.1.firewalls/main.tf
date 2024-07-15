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
module "redis_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "redis"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Redis",
            Name = "Redis"
        }
    )
}
module "mysql_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "mysql"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "mysql",
            Name = "mysql"
        }
    )
}
module "rabbitmq_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "rabbitmq"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "rabbitmq",
            Name = "rabbitmq"
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
module "cart_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "cart"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Cart",
            Name = "Cart"
        }
    )
}
module "user_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "user"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "User",
            Name = "User"
        }
    )
}
module "shipping_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "shipping"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Shipping",
            Name = "Shipping"
        }
    )
}
module "payment_sg" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    sg_name = "payment"
    sg_description = "Allowing traffic"
    #sg_ingress_rules = var.sg_ingress_rules
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    comman_tags = merge(
        var.comman_tags,
        {
            Component = "Payment",
            Name = "Payment"
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
resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  description       = "Allowing port number 27017 from user"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.user_sg.security_group_id
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
resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  description       = "Allowing port number 6379 from cart"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.cart_sg.security_group_id
  security_group_id = module.redis_sg.security_group_id
}
resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  description       = "Allowing port number 6379 from user"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = module.user_sg.security_group_id
  security_group_id = module.redis_sg.security_group_id
}
resource "aws_security_group_rule" "redis_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.redis_sg.security_group_id
}
resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  description       = "Allowing port number 3306 from shipping"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.shipping_sg.security_group_id
  security_group_id = module.mysql_sg.security_group_id
}
resource "aws_security_group_rule" "mysql_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.mysql_sg.security_group_id
}
resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  description       = "Allowing port number 5672 from payment"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = module.payment_sg.security_group_id
  security_group_id = module.rabbitmq_sg.security_group_id
}
resource "aws_security_group_rule" "rabbitmq_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.rabbitmq_sg.security_group_id
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
resource "aws_security_group_rule" "user_app_alb" {
  type              = "ingress"
  description       = "Allowing port number 8080 from app_alb"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id = module.user_sg.security_group_id
}
resource "aws_security_group_rule" "user_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.user_sg.security_group_id
}
resource "aws_security_group_rule" "cart_app_alb" {
  type              = "ingress"
  description       = "Allowing port number 8080 from app_alb"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id = module.cart_sg.security_group_id
}
resource "aws_security_group_rule" "cart_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.cart_sg.security_group_id
}
resource "aws_security_group_rule" "shipping_app_alb" {
  type              = "ingress"
  description       = "Allowing port number 8080 from app_alb"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id = module.shipping_sg.security_group_id
}
resource "aws_security_group_rule" "shipping_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.shipping_sg.security_group_id
}
resource "aws_security_group_rule" "payment_app_alb" {
  type              = "ingress"
  description       = "Allowing port number 8080 from app_alb"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id = module.payment_sg.security_group_id
}
resource "aws_security_group_rule" "payment_vpn" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.payment_sg.security_group_id
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
resource "aws_security_group_rule" "app_alb_catalogue" {
  type              = "ingress"
  description       = "Allowing port number 80 from catalogue"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.catalogue_sg.security_group_id
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_cart" {
  type              = "ingress"
  description       = "Allowing port number 80 from cart"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.cart_sg.security_group_id
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_user" {
  type              = "ingress"
  description       = "Allowing port number 80 from user"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.user_sg.security_group_id
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_shipping" {
  type              = "ingress"
  description       = "Allowing port number 80 from shipping"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.shipping_sg.security_group_id
  security_group_id = module.app_alb_sg.security_group_id
}
resource "aws_security_group_rule" "app_alb_payment" {
  type              = "ingress"
  description       = "Allowing port number 80 from payment"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.payment_sg.security_group_id
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

resource "aws_security_group_rule" "web_vpn_ssh" {
  type              = "ingress"
  description       = "Allowing port number 22 from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id = module.web_sg.security_group_id
}
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