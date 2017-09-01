variable "name_prefix" {
  default = "tf-consul-module-test-"
}

module "vpc" {
  source = "github.com/gbergere/tf-vpc-test-module"

  name_prefix = "${var.name_prefix}"
}

module "consul" {
  source = "../"

  name_prefix = "${var.name_prefix}"

  vpc_id  = "${module.vpc.vpc_id}"
  subnets = ["${module.vpc.subnet_id}"]

  key_name                   = "${module.vpc.key_name}"
  additional_security_groups = ["${module.vpc.security_group}"]
}
