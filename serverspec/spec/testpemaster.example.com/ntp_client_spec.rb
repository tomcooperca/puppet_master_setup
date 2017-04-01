require 'spec_helper'

describe package('ntp') do
  it { should be_installed }
end

describe service('ntpd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/ntp.conf') do
  its(:content) { should match /server 0.pool.ntp.org/ }
  its(:content) { should match /server 1.pool.ntp.org/ }
  its(:content) { should match /server 2.pool.ntp.org/ }
  its(:content) { should match /server 3.pool.ntp.org/ }
end

describe command('ntpq -p') do
  its(:stdout) { should match /0.pool.ntp.org/ }
  its(:stdout) { should match /1.pool.ntp.org/ }
  its(:stdout) { should match /2.pool.ntp.org/ }
  its(:stdout) { should match /3.pool.ntp.org/ }
end
