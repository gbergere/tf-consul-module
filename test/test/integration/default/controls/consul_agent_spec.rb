control 'consul_agent' do
  describe command('docker logs consul') do
    its('stdout') { should match (/agent: Synced service/) }
  end

  describe command("docker exec -t consul consul members") do
    its('stdout') { should match (/alive *server/) }
    its('stdout') { should match (/alive *client/) }
  end
end
