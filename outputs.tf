output "server_security_group" {
  value = "${aws_security_group.server.id}"
}

output "agent_security_group" {
  value = "${aws_security_group.agent.id}"
}

output "public_ip" {
  value = "${aws_instance.consul.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.consul.private_ip}"
}
