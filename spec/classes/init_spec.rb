require 'spec_helper'

describe 'deepsecurityagent' do
  shared_context 'a successful compile and common tests' do |package_name|
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('deepsecurityagent') }
    it { is_expected.to contain_package(package_name).with_ensure('installed') }
    it { is_expected.to contain_service('ds_agent').with_ensure('running') }
    context 'with default value for activate' do
      it { is_expected.not_to contain_class('deepsecurityagent::activation') }
    end

    context 'with activate set to true' do
      let(:params) { { activate: true } }
      it { is_expected.to contain_class('deepsecurityagent::activation') }
    end
  end

  context 'on RedHat distributions' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        architecture: 'x86_64'
      }
    end

    include_context 'a successful compile and common tests', 'ds_agent'
  end

  context 'on Ubuntu distributions' do
    let(:facts) do
      {
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        architecture: 'x86_64'
      }
    end

    include_context 'a successful compile and common tests', 'ds-agent'
  end

  context 'on Suse distributions' do
    let(:facts) do
      {
        osfamily: 'Suse',
        operatingsystem: 'SLES',
        architecture: 'x86_64'
      }
    end

    include_context 'a successful compile and common tests', 'ds_agent'
  end

  context 'on Windows' do
    let(:facts) do
      {
        osfamily: 'windows',
        operatingsystem: 'Windows',
        architecture: 'x64'
      }
    end

    it do
      pending 'Windows catalog fails to compile on non-Windows hosts ' \
        'due to https://github.com/rodjek/rspec-puppet/issues/192'
      is_expected.to compile.with_all_deps
    end
    it { is_expected.to contain_class('deepsecurityagent') }
    it do
      is_expected.to contain_package('Trend Micro Deep Security Agent')
        .with_ensure('installed')
    end
    it { is_expected.to contain_service('ds_agent').with_ensure('running') }
  end

  context 'on an unsupported OS' do
    let(:facts) do
      {
        osfamily: 'foo',
        operatingsystem: 'foo',
        architecture: 'foo'
      }
    end

    it { is_expected.not_to compile }
    it { is_expected.to raise_error(Puppet::Error, /Operating system is not supported by this module/) }
  end
end
