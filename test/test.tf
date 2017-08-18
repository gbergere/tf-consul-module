provider "aws" {
  region = "eu-central-1"
}

module "consul" {
  source = "../"

  name_prefix = "tf-consul-module-test-"

  vpc_id    = "${aws_vpc.test.id}"
  subnet_id = "${aws_subnet.test.id}"

  key_name                   = "${aws_key_pair.test.key_name}"
  additional_security_groups = ["${aws_security_group.test.id}"]
}

output "public_ip" {
  value = "${module.consul.public_ip}"
}
