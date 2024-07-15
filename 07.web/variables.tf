variable "project_name" {
    default = "roboshop"
}
variable "comman_tags" {
    default = {
        Project = "roboshop"
        Environment = "Dev"
        Component = "Web"
        Terraform = "true"
    }
}
variable "environment" {
    default = "dev"
}
variable "target_group_port" {
  default = 80
}
variable "health_check" {
  default = {
        enabled = true
        healthy_threshold = 2
        interval = 15
        matcher = "200-299"
        path = "/"
        port = 80
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 3
  }
}
variable "launch_template_tags" {
    default = [    
        {
            resource_type = "instance"
            tags = {
                Name = "web"
                }
        },
        {
            resource_type = "volume"
            tags = {
                Name = "web"
                }
        },
    ] 
}
variable "autoscale_tags" {
    default = [
        {
            key                 = "Name"
            value               = "Web"
            propagate_at_launch = true
            },
        {
            key                 = "Project"
            value               = "Roboshop"
            propagate_at_launch = true
            }
    ]
}