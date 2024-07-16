module "vpc" {
    source = "git::https://github.com/nareshkonangi9896/terraform-aws-vpc-advanced.git"
    cidr_block = var.cidr_block
    project_name = var.project_name
    comman_tags = var.comman_tags
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    database_subnet_cidr = var.database_subnet_cidr
    is_peering_required = true
    requestor_vpc_id = data.aws_vpc.default.id
    default_route_table_id = data.aws_vpc.default.main_route_table_id
    default_cidr_block = data.aws_vpc.default.cidr_block
}