require 'spec_helper'

describe 'deepsecurityagent::activation' do
  shared_context 'a successful linux activation' do
    let(:dsa_control_command) do
      '/opt/ds_agent/dsa_control -a dsm://agents.deepsecurity.trendmicro.com:443/'
    end

    it do
      is_expected.to contain_exec('Deep Security Agent Activation').with(
        'command' => "#{dsa_control_command}  ",
        'creates' => '/var/opt/ds_agent/dsa_core/ds_agent.config'
      )
        .that_requires('Exec[sleep]')
    end

    it do
      is_expected.to contain_exec('sleep').with(
        'command' => 'sleep 15',
        'creates' => '/var/opt/ds_agent/dsa_core/ds_agent.config'
      )
        .that_comes_before('Exec[Deep Security Agent Activation]')
    end
  end

  shared_context 'successfully handle parameters' do
    context 'with policyid' do
      let(:params) { { policyid: 99 } }

      it do
        is_expected.to contain_exec('Deep Security Agent Activation')
          .with_command(%(#{dsa_control_command}  "policyid:99"))
      end
    end

    context 'with tenant parameters' do
      let(:params) do
        { dsmtenantid: 'foo', dsmtenantpassword: 'bar' }
      end

      it do
        is_expected.to contain_exec('Deep Security Agent Activation')
          .with_command(%(#{dsa_control_command} "tenantID:foo" "tenantPassword:bar" ))
      end
    end

    context 'with policyid and tenant parameters' do
      let(:params) do
        { dsmtenantid: 'foo', dsmtenantpassword: 'bar', policyid: 99 }
      end

      it do
        is_expected.to contain_exec('Deep Security Agent Activation')
          .with_command(%(#{dsa_control_command} "tenantID:foo" "tenantPassword:bar" "policyid:99"))
      end
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

    include_context 'a successful linux activation'
    include_context 'successfully handle parameters'
  end

  context 'on Oracle Linux distributions' do
    let(:facts) do
      {
        osfamily: 'RedHat',
        operatingsystem: 'OracleLinux',
        architecture: 'x86_64'
      }
    end

    include_context 'a successful linux activation'
    include_context 'successfully handle parameters'
  end

  context 'on Ubuntu distributions' do
    let(:facts) do
      {
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        architecture: 'x86_64'
      }
    end

    include_context 'a successful linux activation'
    include_context 'successfully handle parameters'
  end

  context 'on Suse distributions' do
    let(:facts) do
      {
        osfamily: 'Suse',
        operatingsystem: 'SLES',
        architecture: 'x86_64'
      }
    end

    include_context 'a successful linux activation'
    include_context 'successfully handle parameters'
  end

  context 'on Windows' do
    let(:dsa_control_command) do
      '"C:\\Program Files\\Trend Micro\\Deep Security Agent\\dsa_control.cmd" -a dsm://agents.deepsecurity.trendmicro.com:443/'
    end

    let(:facts) do
      {
        osfamily: 'windows',
        operatingsystem: 'Windows',
        architecture: 'x64'
      }
    end

    it do
      is_expected.to contain_exec('Deep Security Agent Activation').with(
        'command' => "#{dsa_control_command}  ",
        'creates' => 'C:/ProgramData/Trend Micro/Deep Security Agent/dsa_core/ds_agent.config'
      )
    end

    it do
      is_expected.to contain_exec('sleep').with(
        'command' => 'ping 127.0.0.1 -n 50',
        'creates' => 'C:/ProgramData/Trend Micro/Deep Security Agent/dsa_core/ds_agent.config'
      )
    end

    include_context 'successfully handle parameters'
  end
end
