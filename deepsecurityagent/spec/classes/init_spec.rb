require 'spec_helper'
describe 'deepsecurityagent' do

  context 'with defaults for all parameters' do
    it { should contain_class('deepsecurityagent') }
  end
end
