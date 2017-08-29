variable "name_prefix" {
  default = "tf-"
}

variable "vpc_id" {}
variable "subnet_id" {}

variable "key_name" {}

variable "cluster_size" {
  default = 3
}

variable "instance_type" {
  default = "t2.micro"
}

variable "additional_security_groups" {
  type = "list"
}
