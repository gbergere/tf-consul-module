control 'consul_ui' do
  describe command('curl -I http://localhost:8500/ui') do
    its('stdout') { should match /301/ }
  end
end
