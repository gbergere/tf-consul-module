# Terraform Module for Consul

This is a terraform module to bring up and running a hashicorp consul cluster.

This module use `test-kitchen` and `inspec` in order to be tested with
[TravisCI](https://travis-ci.org/gbergere/tf-consul-module).

## Requirements

* VPC
* Subnet
* SSH Keypair

## How To Use

### Parameters
* `vpc_id`: String (required)
* `subnet_id`: String (required)
* `key_name`: String (required)
* `name_prefix`: String (optional, default: `tf-`)
* `instance_type`: String (optional, default: `t2.micro`)
* `additional_security_groups`: List (optional)

### Sample
```hcl
module "consul" {
  source = "github.com/gbergere/tf-consul-module"

  vpc_id    = "${var.vpc_id}"
  subnet_id = "${var.subnet_id}"

  key_name = "${var.key_name}"
}

variable "vpc_id" {}

variable "subnet_id" {}

variable "key_name" {}
```
