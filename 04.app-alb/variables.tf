variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Component = "App-ALB"
        Environment = "Dev"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}