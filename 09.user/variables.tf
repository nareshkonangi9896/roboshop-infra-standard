variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Component = "user"
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
                Name = "user"
                }
        },
        {
            resource_type = "volume"
            tags = {
                Name = "user"
                }
        },
    ] 
}
variable "autoscale_tags" {
    default = [
        {
            key                 = "Name"
            value               = "user"
            propagate_at_launch = true
            },
        {
            key                 = "Project"
            value               = "Roboshop"
            propagate_at_launch = true
            }
    ]
}