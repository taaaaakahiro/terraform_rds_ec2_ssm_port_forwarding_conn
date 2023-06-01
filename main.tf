module "rds_bastion" {
  source        = "./modules/bastion"
  env           = local.env
  service       = local.service
  ami           = local.ami
  instance_type = local.instance_type
}