data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}
data "aws_vpc" "default" {
  default = true
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}