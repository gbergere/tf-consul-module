resource "aws_key_pair" "test" {
  key_name   = "tf-consul-module-test"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
