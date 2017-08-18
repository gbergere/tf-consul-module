control 'operating_system' do
  describe command('uname -a') do
    its('stdout') { should match (/coreos/) }
  end
end
