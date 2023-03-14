module "my_vpc" {
    #count = terraform.workspace == "dev" ? 1 : 0
    source = "./modules/vpc"
    #count  = var.create_vpc ? 1 : 0
    vpc_cidrs = var.vpc_cidrs
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.public_subnet_cidrs
    azs = var.azs
}
module "my_ec2" {
    #count = terraform.workspace == "dev" ? 1 : 0
    source = "./modules/ec2"
    #count  = var.create_ec2 ? 1 : 0
    subnet_id = module.my_vpc.subnet_id
    ami_id = var.ami_id
    instance_type = var.instance_type
    vpc_sg_id = module.my_vpc.vpc_sg_id
    #vpc_security_group_id = module.my_vpc.vpc_sg_id
    depends_on = [
      module.my_vpc
    ]
}

module "my_alb" {
    #count = terraform.workspace == "qa" ? 1 : 0
    source = "./modules/alb"
    count  = var.create_alb ? 1 : 0
    # depends_on = [
    #   module.my_vpc,
    #   module.my_ec2
    # ]

}