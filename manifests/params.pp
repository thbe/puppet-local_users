# Class: local_users::params
#
# This module manages local user parameter
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include local_users::params
#
class local_users::params {
  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      $linux                 = true

      # Package definition
      $package_common        = ''

      # Config definition
      $config_file           = '/etc/login.defs'
      $config_file_template  = 'local_users/etc/login.defs.erb'

      # Service definition
      $service_file          = ''
    }
    default  : {
      $linux                 = false
    }
  }

  # Local user definitions
  $root_password_hash = '!!'
}
