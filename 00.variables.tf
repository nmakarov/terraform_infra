variable "aws_access_key" {
	default = "xxx"
}

variable "aws_secret_key" {
	default = "xxx"
}

variable "aws_region" {
	default = "ca-central-1"
}

variable "namespace" {
    description = "mlsfarm namespace"
    default = "mlsfarm"
}

variable "vpc_cidr" {
    default = "10.1.0.0/16"
}

variable "cidr_blocks" {
    description = "this is where everything will live"
    default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "tld" {
    description = "Top level domain to attach subdomains to"
}

variable "rsa_key" {
    description = "name of the pub/pri key group"
}
