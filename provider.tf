
provider "aws" {
  profile = "your profile name"
}

module "s3_static_website" {
 source = "./modules/s3/"
}