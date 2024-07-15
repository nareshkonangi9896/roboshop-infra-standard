variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Component = "cart"
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
                Name = "cart"
                }
        },
        {
            resource_type = "volume"
            tags = {
                Name = "cart"
                }
        },
    ] 
}
variable "autoscale_tags" {
    default = [
        {
            key                 = "Name"
            value               = "cart"
            propagate_at_launch = true
            },
        {
            key                 = "Project"
            value               = "Roboshop"
            propagate_at_launch = true
            }
    ]
}