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
  subnet_id     = "${module.vpc.subnet_id}"
  key_name      = "${module.vpc.key_name}"

  user_data = "${data.template_file.bootstrap_etcd.rendered}"

  vpc_security_group_ids = [
    "${module.consul.agent_security_group}",
    "${module.vpc.security_group}",
    "${aws_security_group.client.id}",
  ]

  tags {
    Name = "${var.name_prefix}-agent"
  }
}

resource "aws_security_group" "client" {
  vpc_id      = "${module.vpc.vpc_id}"
  name_prefix = "${var.name_prefix}-client-"
  description = "Security group used to test tf-consul-module (client)"

  egress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
