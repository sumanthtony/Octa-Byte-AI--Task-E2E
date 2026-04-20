terraform {
backend "s3" {
bucket = "hemanth.b.99"
key = "iac/statefiles/terraform.tfstate"
region = "ap-south-1"
}
}

