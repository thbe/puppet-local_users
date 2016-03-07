# Class: local_users
# ===========================
#
# This is the local_users module. This module create local users.
#
# Parameters
# ----------
#
# Here is the list of parameters used by this module.
#
# * `manage_root`
#   Define if root user schould be managed
#   Default value is false
#
# * `root_password_hash`
#   Define password for root user
#   Default value is disabled password
#
# * `users`
#   Define local user array
#   Default value is undef
#
# Variables
# ----------
#
# No additonal variables are required for this module
#
# Examples
# --------
#
# @example
#    class { 'local_users':
#      users => {
#        { 'john' => { comment => 'John Doe', home => '/export/home/john' } },
#        { 'jane' => { comment => 'Jane Doe', home => '/export/home/jane' } }
#      },
#    }
#
# Authors
# -------
#
# Thomas Bendler <project@bendler-net.de>
#
# Copyright
# ---------
#
# Copyright 2016 Thomas Bendler, unless otherwise noted.
#
# Hash[String, Struct[
# {
#   comment  => Optional[String],
#   password => Optional[String],
#   home     => Optional[String],
#   shell    => Optional[String],
#   groups   => Optional[String]
# }]] $users           = { 'none' => { comment => 'none' } }
class local_users (
  $manage_root         = false,
  $root_password_hash  = $local_users::params::root_password_hash,
  $users               = 'none'
) inherits local_users::params {

  # Start workflow
  if $local_users::params::linux {
    # Setup login defaults
    file { $local_users::params::config_file:
      ensure  => file,
      mode    => '0644',
      content => template($local_users::params::config_file_template);
    }

    # Manage root account if enabled
    if $local_users::manage_root {
      user { 'root':
        ensure   => present,
        home     => '/root',
        shell    => '/bin/bash',
        password => $local_users::root_password_hash;
      }
    }

    # Create user accounts
    if local_users::users != 'none' {
      $users.each |$id, $attributes | {
        user { $id:
          ensure     => present,
          managehome => true,
          *          => $attributes
        }
      }
    }
  } else {
    warning('The current operating system is not supported!')
  }
}
