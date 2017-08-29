resource "aws_iam_instance_profile" "consul" {
  name = "${var.name_prefix}consul-server-profile"
  role = "${aws_iam_role.consul.name}"
}

resource "aws_iam_role" "consul" {
  name = "${var.name_prefix}consul-server-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ec2" {
  name       = "ec2@ConsulAutoJoin attachment"
  roles      = ["${aws_iam_role.consul.name}"]
  policy_arn = "${aws_iam_policy.ec2.arn}"
}

resource "aws_iam_policy" "ec2" {
  name = "ec2@ConsulAutoJoin"
  path = "/"

  policy = "${data.aws_iam_policy_document.ec2.json}"
}

data "aws_iam_policy_document" "ec2" {
  # To Auto-Join Consul cluster
  statement {
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}
