# == Class: deepsecurityagent
#
# Full description of class deepsecurityagent here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'deepsecurityagent':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class deepsecurityagent (
  $dsmheartbeataddress = $deepsecurityagent::params::dsmagentaddress,
  $dsmconsoleaddress = $deepsecurityagent::params::dsmconsoleaddress,
  $dsmheartbeatport = $deepsecurityagent::params::dsmheartbeatport,
  $dsmconsoleport = $deepsecurityagent::params::dsmconsoleport,
  $dsmtenantid = $deepsecurityagent::params::dsmtenantid,
  $dsmtenantpassword = $deepsecurityagent::params::dsmtenantpassword,
  $policyid = $deepsecurityagent::params::policyid,
  $activate = false,
) inherits deepsecurityagent::params {

  notice ("called with activation = $activate")
  if $activate == false {

    class { '::deepsecurityagent::install': } ->
    class { '::deepsecurityagent::service': }
  }
  else {
  	class { '::deepsecurityagent::install': } ->
    class { '::deepsecurityagent::service': } ->
    class { '::deepsecurityagent::activation': }
  }
}
