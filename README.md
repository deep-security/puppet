# deepsecurityagent

## Support

This is a community project and while you will see contributions from the Deep Security team, there is no official Trend Micro support for this project. The official documentation for the Deep Security APIs is available from the [Trend Micro Online Help Centre](http://docs.trendmicro.com/en-us/enterprise/deep-security.aspx).

Tutorials, feature-specific help, and other information about Deep Security is available from the [Deep Security Help Center](https://help.deepsecurity.trendmicro.com/Welcome.html).

For Deep Security specific issues, please use the regular Trend Micro support channels. For issues with the code in this repository, please [open an issue here on GitHub](https://github.com/deep-security/puppet/issues).

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with deepsecurityagent](#setup)
    * [What deepsecurityagent affects](#what-deepsecurityagent-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with deepsecurityagent](#beginning-with-deepsecurityagent)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manage installation and activation of the Deep Security Agent. Supported platforms include Windows, RHEL, CentOS, Amazon Linux, Ubuntu, and SuSE.

## Module Description

Contains functionality to enforce Deep Security agent is running. Includes capability to activate the Deep Security Agent against primary tenant or a tenant a managed service. Policy assignment during activation is optional.

## Setup

### What deepsecurityagent affects

Will install the latest Deep Security Agent package for the platform from the Deep Security Manager specified.
### Setup Requirements **OPTIONAL**

Requires a Deep Security Manager FQDN. Defaults to Trend Micro Deep Security as a Service

### Beginning with deepsecurityagent

Bare minimum configuration for a node is:

class { "deepsecurity" : }

This will default to installing the latest package from Trend Micro Deep Security as a Service, and will not activate the agent.

## Usage

To install package from a Deep Security Manager other than Trend Micro Deep Security as a Service:

class { "deepsecurityagent" :
        dsmheartbeataddress => 'dsm.heartbeat.domain.tld',
        dsmconsoleaddress => 'dsm.console.domain.tld',
        dsmheartbeatport => '4120',
        dsmconsoleport => '4119',
}

To activate the agent against a managed service (tenant ID and password are optional):

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

To specify download and install options for the package, e.g. insecurely download rpm, install locally and skip verification:

class { "deepsecurityagent" :
        dsmheartbeataddress => 'dsm.heartbeat.domain.tld',
        dsmconsoleaddress => 'dsm.console.domain.tld',
        dsmheartbeatport => '4120',
        dsmconsoleport => '4119',
        local_rpm_install => true,
        curl_command => 'curl -k',
        download_opts => '--insecure --silent --tlsv1.2',
        install_opts => '--nosignature',
}


## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
