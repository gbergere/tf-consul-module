control 'consul_dns' do
  describe command('nslookup www.google.com') do
    its('stdout') { should_not include "** server can't find " }
  end

  describe command('nslookup consul.service.consul') do
    its('stdout') { should_not include "** server can't find " }
  end
end
