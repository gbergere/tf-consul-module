resource "aws_security_group" "agent" {
  name_prefix = "${var.name_prefix}consul-agent-ec2-"
  description = "Consul (Agent) Security Group EC2"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "${var.name_prefix}consul-agent-ec2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_8301_tcp_in" {
  security_group_id = "${aws_security_group.agent.id}"
  type              = "ingress"

  from_port = 8301
  to_port   = 8301
  protocol  = "tcp"
  self      = true
}

resource "aws_security_group_rule" "allow_8301_udp_in" {
  security_group_id = "${aws_security_group.agent.id}"
  type              = "ingress"

  from_port = 8301
  to_port   = 8301
  protocol  = "udp"
  self      = true
}

resource "aws_security_group_rule" "allow_8300_tcp_out" {
  security_group_id = "${aws_security_group.agent.id}"
  type              = "egress"

  from_port = 8300
  to_port   = 8300
  protocol  = "tcp"

  source_security_group_id = "${aws_security_group.server.id}"
}

resource "aws_security_group_rule" "allow_8301_tcp_out" {
  security_group_id = "${aws_security_group.agent.id}"
  type              = "egress"

  from_port = 8301
  to_port   = 8301
  protocol  = "tcp"
  self      = true
}

resource "aws_security_group_rule" "allow_8301_udp_out" {
  security_group_id = "${aws_security_group.agent.id}"
  type              = "egress"

  from_port = 8301
  to_port   = 8301
  protocol  = "udp"
  self      = true
}
