data "aws_ami" "core" {
  most_recent = true
  owners      = ["595879546273"]

  filter {
    name   = "name"
    values = ["CoreOS-stable*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "bootstrap_etcd" {
  template = "${file("${path.module}/bootstrap_agent.yml")}"

  vars {
    consul_servers = "${module.consul.private_ip}"
  }
}

resource "aws_instance" "agent" {
  instance_type = "t2.small"
  ami           = "${data.aws_ami.core.id}"
  subnet_id     = "${aws_subnet.test.id}"
  key_name      = "${aws_key_pair.test.key_name}"

  user_data = "${data.template_file.bootstrap_etcd.rendered}"

  vpc_security_group_ids = [
    "${module.consul.agent_security_group}",
    "${aws_security_group.test.id}",
  ]

  tags {
    Name = "tf-consul-module-test-agent"
  }
}
