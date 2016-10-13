class deepsecurityagent::service inherits deepsecurityagent{

  service { $deepsecurityagent::params::agentservice :
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
  }
}
