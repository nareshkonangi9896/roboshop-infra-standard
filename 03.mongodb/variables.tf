variable "project_name" {
    default = "roboshop"
}
variable "sg_name" {
    default = "mongodb"
}
variable "sg_description" {
    default = "allowing traffic"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Component = "Mongodb"
        Environment = "Dev"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}