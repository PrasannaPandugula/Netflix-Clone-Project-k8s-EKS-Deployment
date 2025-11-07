variable "aws-region" {}
variable "cidr-block" {}
variable "env" {}

variable "pub-cidr-block" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "ec2-instances" {
  type = map(object({
    type = string 
    subnet = string
  }))
}
variable "ec2_volume_size" {}
variable "ec2_volume_type" {}