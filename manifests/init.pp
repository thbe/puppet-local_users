# Class: local_users
# ===========================
#
# Full description of class local_users here.
# This is the icinga module. This module install all things
# required to setup Icinga 2.
#
# Parameters
# ----------
#
# Here is the list of parameters used by this module.
#
# * `user`
#   Define local user
#   Default value is none
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
#      user => [ 'user1', 'user2' ],
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
# Copyright 2015 Thomas Bendler, unless otherwise noted.
#
class local_users (
  $user               = [ 'none' ],
) inherits local_users::params {

  # Start workflow
  if $local_users::params::linux {
    # Containment
    contain local_users::config
    contain local_users::config

    # Include classes
    Class['local_users::package'] ->
    Class['local_users::config']
  }
  else {
    warning('The current operating system is not supported!')
  }
}
