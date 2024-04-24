# @summary A puppet class to modify netbt settings in the registry on windows systems
#
# Configure NetBIOSOptions for every interface on a Windows system.  It is security best practice to set this to disabled
#
# @example
#  class { netbt:
#    netbt_setting => 'disabled'
#  }
#
# @param netbt_setting - Set NebiosOptions
#                        - enabled  (Enables NetBIOS over TCP/IP)
#                        - disabled (Disabled NetBIOS over TCP/IP)
#                        - dhcp     (Use NetBIOS setting from the DHCP Server)
class netbt (
  String $netbt_setting = 'dhcp'
) {
  case $netbt_setting {
    'enabled':  {
      $netbiosoptions = 1
    }
    'disabled':  {
      $netbiosoptions = 2
    }
    'dhcp': {
      $netbiosoptions = 0
    }
    default: {
      notify { 'Invalid option for netbt_setting: Defaulting to DHCP selection': }
      $netbiosoptions = 0
    }
  }
  $facts['interface_guids'].each | $key, $value| {
    registry_value { "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NetBT\\Parameters\\Interfaces\\Tcpip_{${value}}\\NetbiosOptions":
      ensure => present,
      type   => dword,
      data   => $netbiosoptions,
    }
  }
}
