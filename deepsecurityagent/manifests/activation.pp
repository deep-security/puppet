# Class: deepsecurityagent::activation inherits deepsecurityagent
#
# resources
#
class deepsecurityagent::activation (
  $dsmtenantid = $deepsecurityagent::dsmtenantid,
  $dsmtenantpassword = $deepsecurityagent::dsmtenantpassword,
  $policyid = $deepsecurityagent::policyid,
) inherits deepsecurityagent {
	
  $dsmheartbeaturl = "dsm://${dsmheartbeataddress}:${dsmheartbeatport}/"
  if $dsmtenantid == '' {
  	$tenantarguments = ''
  }
  else {
  	$tenantarguments = "\"tenantID:${dsmtenantid}\" \"tenantPassword:${dsmtenantpassword}\""
  }
  if $policyid == '' {
  	$policyargument = ''
  }
  else {
  	$policyargument = "\"policyid:${policyid}\""
  }
  $arguments = "${tenantarguments} ${policyargument}"
  if $::osfamily != 'windows' {
    exec {"sleep":
      command => "sleep 10",
      path => "/usr/bin:/bin",
    }
  }
  else {
  	exec {"sleep":
    command => 'timeout /t 10',
    path => '%WINDIR%\\System32\\',
  }
  }
  notice ("activation command is ${deepsecurityagent::params::dsa_control} -a ${dsmheartbeaturl} ${arguments}")
  exec { "Deep Security Agent Tenant Activation":
    command => "${deepsecurityagent::params::dsa_control} -a ${dsmheartbeaturl} ${arguments}",
  }

}
