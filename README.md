# minimum-web-app-terraform-skeleton
Minimum Terraform skeleton (sample) for web app 

# Features
- All resources are defined as terraform module (D-R-Y infra code)
- Allow you create same infra for both test and prod environments with only 1 command
- Comes with minimum setup, you can add everything you need, also custom all settings
    - This skeleton uses EC2 as web server, RDS as database server and S3 as file storage
- Allocate EIP and assign static IP address to your EC2 instance so it's easier for you to setup domain stuffs after
- Create a new VPC for your web app (good practise to not use the default VPC)

# How to deploy
```bash
$ # checkout this repository
$ cd test                           # change to directory of enviroment you want to create (test or prod environment)
$ terraform init && terraform plan  # check what resources will be create
$ terraform apply                   # apply (deploy) all resources
```
