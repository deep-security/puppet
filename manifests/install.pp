class deepsecurityagent::install inherits deepsecurityagent {
  $dsmurl = "https://${dsmconsoleaddress}:${dsmconsoleport}/software/agent"

  debug('Install Class determine OS')

  case $::operatingsystem {
    'windows' : {
      case $::architecture {
        'x86'	: {$agentsource = "${dsmurl}/Windows/i386/"}
        'x64'	: {$agentsource = "${dsmurl}/Windows/x86_64/"}
      }
    }
    'RedHat', 'CentOS' : {
      case $::architecture {
        'x86' : {
          case $::operatingsystemmajrelease {
            '4'	: {$agentsource = "${dsmurl}/RedHat_2.6.9_22.EL_i686/i386/"}
            '5'	: {$agentsource = "${dsmurl}/RedHat_EL5/i386/"}
            '6'	: {$agentsource = "${dsmurl}/RedHat_EL6/i386/"}
          }
        }
        'x86_64' : {
          case $::operatingsystemmajrelease {
            '4'	: {$agentsource = "${dsmurl}/RedHat_2.6.9_34.EL_x86_64/x86_64/"}
            '5'     : {$agentsource = "${dsmurl}/RedHat_EL5/x86_64/"}
            '6'     : {$agentsource = "${dsmurl}/RedHat_EL6/x86_64/"}
            '7'     : {$agentsource = "${dsmurl}/RedHat_EL7/x86_64/"}
          }
        }
      }
    }
    'Amazon' : {
      case $::architecture {
        'x86' : {$agentsource = "${dsmurl}/amzn$::operatingsystemmajrelease/i386/"}
        'x86_64' : {$agentsource = "${dsmurl}/amzn$::operatingsystemmajrelease/x86_64/"}
      }
    }
    'Ubuntu' : {
      case $::architecture {
        'amd64' : {
          case $::operatingsystemrelease {
            '10.04'     : {$agentsource = "${dsmurl}/Ubuntu_10.04/x86_64/"}
            '12.04'     : {$agentsource = "${dsmurl}/Ubuntu_12.04/x86_64/"}
            '14.04'     : {$agentsource = "${dsmurl}/Ubuntu_14.04/x86_64/"}
          }
        }
      }
    }
    'SLES' : {
      case $::architecture {
        'i386' : {
          case $::operatingsystemmajrelease {
            '10'     : {$agentsource = "${dsmurl}/SuSE_10/i386/"}
            '11'     : {$agentsource = "${dsmurl}/SuSE_11/i386/"}
          }
        }
        'x86_64' : {
          case $::operatingsystemmajrelease {
            '10'     : {$agentsource = "${dsmurl}/SuSE_10/x86_64/"}
            '11'     : {$agentsource = "${dsmurl}/SuSE_11/x86_64/"}
            '12'     : {$agentsource = "${dsmurl}/SuSE_12/x86_64/"}
          }
        }
      }
    }
    default: { fail("Please check to ensure you are running an operating system supported by Deep Security Agent and this module") }
  }

  debug("Downloading agent from ${agentsource}")

  case $::osfamily {
    'Redhat', 'CentOS', 'Amazon', 'Linux' :{
      if $::operatingsystemmajrelease == 5 {
        case $::architecture {
          'x86' : {$agentfilesourceR5 = "${dsmurl}/RedHat_EL5/i386/"}
          'x86_64' : {$agentfilesourceR5 = "${dsmurl}/RedHat_EL5/x86_64/"}
        }
        exec { 'Download_RHEL5_Agent':
          command => "curl -k ${agentfilesourceR5} -o /tmp/agent.rpm",
          creates => "/tmp/agent.rpm",
          path => '/usr/bin',
        }
        package {$deepsecurityagent::params::agentpackage:
          ensure => 'installed',
          provider => 'rpm',
          source => "/tmp/agent.rpm",
          require => Exec["Download_RHEL5_Agent"],
        }
      }
    else {
      exec { 'Download_RHEL_Agent':
        command	=> "curl -k ${agentsource} -o /tmp/agent.rpm",
        creates => '/tmp/agent.rpm',
        path => '/usr/bin/',
      }
      package { $deepsecurityagent::params::agentpackage:
        ensure => 'installed',
        provider => 'rpm',
        source => "/tmp/agent.rpm",
        require => Exec["Download_RHEL_Agent"],
      }
    }
  }
    'Suse' :{
      exec { 'Download_Suse_Agent':
        command	=> "curl -k ${agentsource} -o /tmp/agent.rpm",
        creates => '/tmp/agent.rpm',
        path => '/usr/bin/',
      }
      package { $deepsecurityagent::params::agentpackage:
        ensure => 'installed',
        provider => 'rpm',
        source => '/tmp/agent.rpm',
        require => Exec["Download_Suse_Agent"],
      }
    }
    'Debian' :{
      exec { 'Download_Ubuntu_Agent':
        command	=> "curl -k ${agentsource} -o /tmp/agent.deb",
        creates => '/tmp/agent.deb',
        path => '/usr/bin/',
      }
      package { $deepsecurityagent::params::agentpackage:
        ensure => 'installed',
        provider => 'dpkg',
        source => '/tmp/agent.deb',
        require => Exec["Download_Ubuntu_Agent"],
      }
    }
    'windows' : {
      exec { 'Download_Windows_Agent':
        command      => "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -Command \"& { [Net.ServicePointManager]::ServerCertificateValidationCallback = {\$true}; (New-Object System.Net.WebClient).DownloadFile(\\\"${agentsource}\\\", \\\"${::env_windows_installdir}\\agent.msi\\\") } \"",
        path         => "C:\\Windows\\sysnative\\",
        creates      => "${::env_windows_installdir}\\agent.msi"
      }
      package { $deepsecurityagent::params::agentpackage:
        ensure => 'installed',
        source => "${::env_windows_installdir}\\agent.msi",
        require => Exec["Download_Windows_Agent"]

      }
    }
  }
}

