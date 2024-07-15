resource "aws_ssm_parameter" "aws_weblb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/aws_weblb_listener_arn"
  type  = "String"
  value = aws_lb_listener.https.arn
}