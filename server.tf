resource "aws_instance" "consul" {
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.core.id}"
  subnet_id     = "${var.subnet_id}"
  key_name      = "${var.key_name}"

  user_data = "${file("${path.module}/bootstrap.yml")}"

  vpc_security_group_ids = [
    "${aws_security_group.server.id}",
    "${aws_security_group.agent.id}",
    "${var.additional_security_groups}",
  ]

  tags {
    Name = "${var.name_prefix}consul-server"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["ami", "user_data"]
  }
}

resource "aws_security_group" "server" {
  name_prefix = "${var.name_prefix}consul-server-ec2-"
  description = "Consul (Server) Security Group EC2"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.name_prefix}consul-server-ec2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_8300_tcp_in" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "ingress"

  from_port = 8300
  to_port   = 8300
  protocol  = "tcp"

  source_security_group_id = "${aws_security_group.agent.id}"
}

resource "aws_security_group_rule" "allow_8500_tcp_in" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "ingress"

  from_port = 8500
  to_port   = 8500
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "allow_8600_tcp_in" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "ingress"

  from_port = 8600
  to_port   = 8600
  protocol  = "udp"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}
