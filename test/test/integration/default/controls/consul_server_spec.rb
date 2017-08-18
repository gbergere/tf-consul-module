control 'consul_server' do
  describe command('docker logs consul') do
    its('stdout') { should match (/consul: cluster leadership acquired/) }
  end
end
