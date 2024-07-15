variable "project_name" {
    default = "roboshop"
}

variable "comman_tags" {
    default = {
        Project = "roboshop"
        Component = "rabbitmq"
        Environment = "Dev"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}

variable "zone_name" {
    default = "nareshdevops.online"
}