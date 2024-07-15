variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Component = "payment"
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
                Name = "payment"
                }
        },
        {
            resource_type = "volume"
            tags = {
                Name = "payment"
                }
        },
    ] 
}
variable "autoscale_tags" {
    default = [
        {
            key                 = "Name"
            value               = "payment"
            propagate_at_launch = true
            },
        {
            key                 = "Project"
            value               = "Roboshop"
            propagate_at_launch = true
            }
    ]
}