control 'consul_server' do
  describe command('docker logs consul') do
    its('stdout') { should match (/Server: true/) }
    its('stdout') { should match (/consul: New leader elected: /) }
    its('stdout') { should match (/agent: Synced service 'consul'/) }
  end
end
