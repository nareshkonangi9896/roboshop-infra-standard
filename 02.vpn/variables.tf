variable "project_name" {
    default = "roboshop"
}
variable "sg_name" {
    default = "roboshop-vpn"
}
variable "sg_description" {
    default = "allowing all ports from my home IP"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}