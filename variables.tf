variable "name_prefix" {
  default = "tf-"
}

variable "vpc_id" {}

variable "subnets" {
  type = "list"
}

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
