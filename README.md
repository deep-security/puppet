# Puppet for Deep Security Agent

Puppet manifests to install and activate Deep Security Agent. This 
installs the newest version of the agent that is available from your 
Deep Security Manager or Deep Security as a Service.

Optionally, you can also activate the agent with a specific tenant ID, 
assign a policy, and enforce running of the agent.


## Table of Contents

* [Requirements](#requirements)
* [Setup](#setup)
* [Usage](#usage)
* [Support](#support)
* [Contribute](#contribute)


## Requirements

Supported Deep Security Agent platforms include Windows, RHEL, CentOS, Amazon Linux, Ubuntu, and SuSE.


## Setup

Bare minimum configuration for a node is:

class { "deepsecurity" : }

This will default to installing the latest package from Trend Micro Deep 
Security as a Service, and will not activate the agent.


## Usage

Defaults to Trend Micro Deep Security as a Service. To install package from a Deep Security Manager that is **not** Trend Micro Deep Security as a Service:

class { "deepsecurityagent" :
  dsmheartbeataddress => 'dsm.heartbeat.example.com',
  dsmconsoleaddress => 'dsm.console.example.com',
  dsmheartbeatport => '4120',
  dsmconsoleport => '4119',
}

To activate the agent with a managed service (tenant ID and password are optional):

class { "deepsecurityagent::activation" :
  dsmtenantid => 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
  dsmtenantpassword => 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
}

To activate and request a policy (tenant ID and password are optional):

class { "deepsecurityagent::activation" :
  dsmtenantid => 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
  dsmtenantpassword => 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
  policyid => '1'
}


## Support

This is an Open Source community project. Project contributors may be able to help, 
depending on their time and availability. Please be specific about what you're 
trying to do, your system, and steps to reproduce the problem.

For bug reports or feature requests, please 
[open an issue](../issues). 
You are welcome to [contribute](#contribute).

Official support from Trend Micro is not available. Individual contributors may be 
Trend Micro employees, but are not official support.

## Contribute

We accept contributions from the community. To submit changes:

1. Fork this repository.
1. Create a new feature branch.
1. Make your changes.
1. Submit a pull request with an explanation of your changes or additions.

We will review and work with you to release the code.
