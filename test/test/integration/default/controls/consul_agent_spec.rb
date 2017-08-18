control 'consul_agent' do
  describe command('docker logs consul') do
    its('stdout') { should match (/Server: false/) }
    its('stdout') { should match (/agent: Synced service/) }
  end
end
