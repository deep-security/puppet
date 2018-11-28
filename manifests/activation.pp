# Class: deepsecurityagent::activation inherits deepsecurityagent
#
# resources
#
class deepsecurityagent::activation (
        Optional[String] $dsmtenantid           = $deepsecurityagent::dsmtenantid,
        Optional[String] $dsmtenantpassword     = $deepsecurityagent::dsmtenantpassword,
        Optional[String] $policyid              = $deepsecurityagent::policyid,
) inherits deepsecurityagent {
        debug("tenantid is ${dsmtenantid}")
        debug("tenantpassword is ${dsmtenantpassword}")

        $dsmheartbeaturl        = "dsm://${deepsecurityagent::dsmheartbeataddress}:${deepsecurityagent::dsmheartbeatport}/"

        if ($dsmtenantid) {
                $tenantarguments = "\"tenantID:${dsmtenantid}\" \"tenantPassword:${dsmtenantpassword}\""
        }

        if ($policyid) {
                $policyargument = "\"policyid:${policyid}\""
        }

        $arguments = "${tenantarguments} ${policyargument}"

        if $::osfamily != 'windows' {
                exec {'sleep':
                        command => 'sleep 15',
                        path    => '/usr/bin:/bin',
                        creates => $deepsecurityagent::params::dsa_config_file,
                }
        }
        else {
                exec {'sleep':
                        command => 'ping 127.0.0.1 -n 50',
                        path    => $::path,
                        creates => $deepsecurityagent::params::dsa_config_file,
                }
        }

        debug("activation command is ${deepsecurityagent::params::dsa_control} -a ${dsmheartbeaturl} ${arguments}")

        exec { 'Deep Security Agent Activation':
                command => "${deepsecurityagent::params::dsa_control} -a ${dsmheartbeaturl} ${arguments}",
                require => Exec['sleep'],
                creates => $deepsecurityagent::params::dsa_config_file,
        }
}
