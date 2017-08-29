resource "random_id" "cluster_id" {
  keepers = {
    profile = "${aws_iam_instance_profile.consul.name}"
  }

  byte_length = 8
}
