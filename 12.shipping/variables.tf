variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Component = "shipping"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}
variable "launch_template_tags" {
    default = [    
        {
            resource_type = "instance"
            tags = {
                Name = "shipping"
                }
        },
        {
            resource_type = "volume"
            tags = {
                Name = "shipping"
                }
        },
    ] 
}
variable "autoscale_tags" {
    default = [
        {
            key                 = "Name"
            value               = "shipping"
            propagate_at_launch = true
            },
        {
            key                 = "Project"
            value               = "Roboshop"
            propagate_at_launch = true
            }
    ]
}