# puppet_netbt

### This module modifies the netbiosoptions registry setting for all interfaces on a Windows system.

#### Overview
This module controls whether NetBIOS is enabled on all interfaces. Note: Due to the registry key that is created, the registry key DHCPNetbiosOptions is ignored. If you need to use dhcp to control this, just set the `netbt_setting` parameter to say so within this module.

###### Doing a regular include of this module will ensure that the dhcp server is the source of this setting.

```puppet
include netbt
```

###### A parameterized instantiation of this module will allow you to explicitly enable or disable netbios for all interfaces.

```puppet
class { netbt:
  netbt_setting => 'disabled'
}
```

### Options:

`netbt_setting:`
The NetBIOS options are 'Enable NetBIOS over TCP\IP', 'Disable NetBIOS over TCP\IP', or 'Use NetBIOS setting from the DHCP' server. The default is to use NetBIOS setting from DHCP server. Choose from `enabled`, `disabled`, or `dhcp` to explicitly set this.
