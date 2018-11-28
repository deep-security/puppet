class deepsecurityagent::params {
        $activate               = false
        $dsmconsoleaddress      = 'app.deepsecurity.trendmicro.com'
        $dsmagentaddress        = 'agents.deepsecurity.trendmicro.com'
        $dsmheartbeatport       = '443'
        $dsmconsoleport         = '443'
        $dsmtenantid            = undef
        $dsmtenantpassword      = undef
        $policyid               = undef

        $curl_command           = 'curl'
        $download_opts          = undef
        $install_opts           = undef
        $local_rpm_install      = false

        case $::osfamily {
                'windows' : {
                        $dsa_control     = '"C:\Program Files\Trend Micro\Deep Security Agent\dsa_control.cmd"'
                        $agentpackage    = 'Trend Micro Deep Security Agent'
                        $agentservice    = 'ds_agent'
                        $dsa_config_file = 'C:/ProgramData/Trend Micro/Deep Security Agent/dsa_core/ds_agent.config'
                }
                'Suse' : {
                        $dsa_control     = '/opt/ds_agent/dsa_control'
                        $agentpackage    = 'ds_agent'
                        $agentservice    = 'ds_agent'
                        $dsa_config_file = '/var/opt/ds_agent/dsa_core/ds_agent.config'
                }
                'RedHat' : {
                        $dsa_control     = '/opt/ds_agent/dsa_control'
                        $agentpackage    = 'ds_agent'
                        $agentservice    = 'ds_agent'
                        $dsa_config_file = '/var/opt/ds_agent/dsa_core/ds_agent.config'
                }
                'Debian' : {
                        $dsa_control     = '/opt/ds_agent/dsa_control'
                        $agentpackage    = 'ds-agent'
                        $agentservice    = 'ds_agent'
                        $dsa_config_file = '/var/opt/ds_agent/dsa_core/ds_agent.config'
                }
                #prior to facter 1.7, facter returns 'Linux' for ::osfamily on amazon linux
                'Linux' : {
                        case $::operatingsystem {
                                'Amazon': {
                                        $dsa_control     = '/opt/ds_agent/dsa_control'
                                        $agentpackage    = 'ds_agent'
                                        $agentservice    = 'ds_agent'
                                        $dsa_config_file = '/var/opt/ds_agent/dsa_core/ds_agent.config'
                                }
                        }
                }
                default: { fail('Operating system is not supported by this module') }
        }
}
