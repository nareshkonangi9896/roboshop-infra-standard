module "web" {
    source = "../../terraform-roboshop-app"
    project_name = var.project_name
    comman_tags =var.comman_tags
    environment = var.environment

    #target_group
    target_group_port = var.target_group_port
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    health_check = var.health_check

    #launch_template
    image_id = data.aws_ami.devops_ami.id
    security_group_id = data.aws_ssm_parameter.web_sg_id.value
    launch_template_tags = var.launch_template_tags
    user_data = filebase64("${path.module}/web.sh")

    #aws_autoscaling_group
    vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
    autoscale_tags = var.autoscale_tags

    #autoscaling policy - no inputs

    #listener_rule
    alb_listener_arn = data.aws_ssm_parameter.aws_weblb_listener_arn.value
    rule_priority = 10
    host_header = "nareshdevops.online"

}