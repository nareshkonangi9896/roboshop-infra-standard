module "user" {
    source = "../../terraform-roboshop-app"
    project_name = var.project_name
    comman_tags =var.comman_tags
    environment = var.environment

    #target_group
    vpc_id = data.aws_ssm_parameter.vpc_id.value

    #launch_template
    image_id = data.aws_ami.devops_ami.id
    security_group_id = data.aws_ssm_parameter.user_sg_id.value
    launch_template_tags = var.launch_template_tags
    user_data = filebase64("${path.module}/user.sh")

    #aws_autoscaling_group
    vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
    autoscale_tags = var.autoscale_tags

    #autoscaling policy - no inputs

    #listener_rule
    alb_listener_arn = data.aws_ssm_parameter.aws_lb_listener_arn.value
    rule_priority = 20
    host_header = "user.app.nareshdevops.online"

}