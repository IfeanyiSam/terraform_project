module "vpc" {
    source = "terraform-aws-module/vpc/aws"

    name = var.VPC_NAME
    cidr = var.VPC_CIDR
    azs = [var.ZONE1, var.ZONE2, var.ZONE3]
    private_subnets = [var.PRIVSUB1CIDR, var.PRIVSUB2CIDR, var.PRIVSUB3CIDR]
    public_subnets = [var.PUBSUB1CIDR, var.PUBSUB2CIDR, var.PUBSUB3CIDR]
    enable_nat_gateway = true
    single_nat_gateway = true
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Terraform = "true"
        Environment = "test"
    }
    vpc_tags = {
        Name = var.VPC_NAME
    }
}
