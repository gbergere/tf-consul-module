output "server_ip" {
  value = "${module.consul.public_ip}"
}

output "agent_ip" {
  value = "${aws_instance.agent.public_ip}"
}

output "cluster_ip" {
  value = "${module.consul.private_ip}"
}
