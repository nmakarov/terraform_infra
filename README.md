## Setup

1. make sure RSA key pair is created (here, terraform_rsa and terraform_rsa.pub), private key `terraform_rsa` is placed in `~/.ssh/` and public key `terraform_rsa.pub` is in `files/`

2. create `terraform.tfvars` file with the following contents:
```
aws_access_key = "xxx"
aws_secret_key = "xxx"
aws_region = "ca-central-1"
tld = "mlsfarm.xxx.com"
rsa_key = "terraform_rsa"
```

3. run the following:
```
terraform init
terraform apply
```
And in a few mins see what happens.
