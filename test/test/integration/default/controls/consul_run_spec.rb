control 'consul_run' do
  describe docker_container(name: 'consul') do
    it { should exist }
    it { should be_running }
  end
end
