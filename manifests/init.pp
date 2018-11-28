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
        Boolean $activate               = $deepsecurityagent::params::activate,
        String $dsmheartbeataddress     = $deepsecurityagent::params::dsmagentaddress,
        String $dsmconsoleaddress       = $deepsecurityagent::params::dsmconsoleaddress,
        String $dsmheartbeatport        = $deepsecurityagent::params::dsmheartbeatport,
        String $dsmconsoleport          = $deepsecurityagent::params::dsmconsoleport,
        Optional[String] $dsmtenantid   = $deepsecurityagent::params::dsmtenantid,
        Optional[String] $dsmtenantpassword     = $deepsecurityagent::params::dsmtenantpassword,
        Optional[String] $policyid      = $deepsecurityagent::params::policyid,
        String $curl_command            = $deepsecurityagent::params::curl_command,
        Optional[String] $download_opts = $deepsecurityagent::params::download_opts,
        Optional[String] $install_opts  = $deepsecurityagent::params::install_opts,
        Boolean $local_rpm_install      = $deepsecurityagent::params::local_rpm_install,
) inherits deepsecurityagent::params {

        debug("called with activation = $activate")

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
