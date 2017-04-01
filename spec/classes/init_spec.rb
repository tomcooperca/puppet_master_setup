require 'spec_helper'
describe 'puppet_master_setup' do
  context 'with default values for all parameters' do
    it { should contain_class('puppet_master_setup') }
  end
end
