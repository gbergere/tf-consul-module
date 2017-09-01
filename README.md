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
* `subnets`: List (required)
* `key_name`: String (required)
* `name_prefix`: String (optional, default: `tf-`)
* `cluster_size`: Integer (optional, default: `3`)
* `instance_type`: String (optional, default: `t2.micro`)
* `additional_security_groups`: List (optional)

### Sample
```hcl
module "consul" {
  source = "github.com/gbergere/tf-consul-module"

  vpc_id  = "${var.vpc_id}"
  subnets = ["${var.subnet}"]

  key_name = "${var.key_name}"
}

variable "vpc_id" {}

variable "subnet" {}

variable "key_name" {}
```
