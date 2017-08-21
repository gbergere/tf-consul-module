cluster_ip = attribute "cluster_ip", {}

control 'consul_agent' do
  describe command('docker logs consul') do
    its('stdout') { should match (/Server: false/) }
    its('stdout') { should match (/agent: Synced service/) }
  end

  describe command("docker exec -t consul consul members -http-addr=#{cluster_ip}:8500") do
    its('stdout') { should match (/alive *server/) }
    its('stdout') { should match (/alive *client/) }
  end
end
