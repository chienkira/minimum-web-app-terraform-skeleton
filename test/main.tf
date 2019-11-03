provider "aws" {
  region  = "ap-northeast-1"
  profile = "greatapp"
}

terraform {
  backend "s3" {
    bucket = "greatapp-terraform-states"
    key    = "test.env.tfstate"
    region = "us-east-1"
    profile = "greatapp"
  }
}

module "greatapp" {
  env = "test"
  source = "../_resources"

  aws_key_name = "greatapp_key_test"
  ec2_disk_size = 20 #GB
  ec2_instance_type = "t2.micro"

  rds_instance_class = "db.t2.micro"
  rds_disk_size = 20 #GB
  rds_max_disk_size = 50 #GB
  rds_password = "postgres"
}
