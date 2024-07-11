variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Component = "Catalogue"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}