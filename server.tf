data "template_file" "bootstrap" {
  template = "${file("${path.module}/bootstrap.yml")}"

  vars {
    cluster_id   = "${random_id.cluster_id.hex}"
    cluster_size = "${var.cluster_size}"
  }
}

resource "aws_instance" "consul" {
  count = "${var.cluster_size}"

  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.core.id}"
  subnet_id     = "${element(var.subnets, count.index % length(var.subnets))}"
  key_name      = "${var.key_name}"

  iam_instance_profile = "${aws_iam_instance_profile.consul.name}"
  user_data            = "${data.template_file.bootstrap.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.server.id}",
    "${aws_security_group.agent.id}",
    "${var.additional_security_groups}",
  ]

  tags {
    Name          = "${var.name_prefix}consul-server-${count.index}"
    ConsulCluster = "${random_id.cluster_id.hex}"
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
    Name          = "${var.name_prefix}consul-server-ec2"
    ConsulCluster = "${random_id.cluster_id.hex}"
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

resource "aws_security_group_rule" "allow_8302_tcp_in" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "ingress"

  from_port = 8302
  to_port   = 8302
  protocol  = "tcp"
  self      = true
}

resource "aws_security_group_rule" "allow_8302_udp_in" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "ingress"

  from_port = 8302
  to_port   = 8302
  protocol  = "udp"
  self      = true
}

resource "aws_security_group_rule" "allow_8302_tcp_out" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "egress"

  from_port = 8302
  to_port   = 8302
  protocol  = "tcp"
  self      = true
}

resource "aws_security_group_rule" "allow_8302_udp_out" {
  security_group_id = "${aws_security_group.server.id}"
  type              = "egress"

  from_port = 8302
  to_port   = 8302
  protocol  = "udp"
  self      = true
}
