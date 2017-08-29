output "server_ips" {
  value = "${module.consul.public_ips}"
}

output "agent_ip" {
  value = "${aws_instance.agent.public_ip}"
}

output "consul_server" {
  value = "${module.consul.consul_server}"
}
