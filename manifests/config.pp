# Class: common::config::users
#
# This module manages common user
#
# Parameters: none
#
# Actions: Install specified common user
#
# Requires: common
#
# Sample Usage:
#
class common::config::user inherits common::params {
  case $::osfamily {
    'RedHat' : {
      file { '/etc/login.defs':
        ensure  => present,
        mode    => 644,
        owner   => root,
        group   => root,
        content => template('common/etc/login.defs.erb');
      }
    }
  }

  user { 'root':
    ensure   => present,
    uid      => '0',
    gid      => '0',
    comment  => 'root',
    home     => '/root',
    shell    => '/bin/bash',
    password => '$6$JAUbqfRk$qNes0gk5MeN5oqeTau/LN7yAstlCbOc6a8Saj.krdcfi/w6kGKCNWpZzdOjJ.IvYEVYq3SLRCnXPW.5qJg2oQ0';
  }

  file {
    '/root/.bashrc':
      ensure  => present,
      mode    => 644,
      owner   => root,
      group   => root,
      content => template('common/etc/user/bashrc.erb');

    '/root/.bash_aliases':
      ensure  => present,
      mode    => 644,
      owner   => root,
      group   => root,
      content => template('common/etc/user/bash_aliases.erb');
  }

  $os_admin_group = 'wheel'

  group {
    'sysadm':
      ensure => present,
      gid    => 500;

    'sysop':
      ensure => present,
      gid    => 501;
  }

  user {
    'sysadm':
      ensure     => present,
      uid        => '500',
      gid        => 'sysadm',
      comment    => 'System Administrator',
      home       => '/home/sysadm',
      shell      => '/bin/bash',
      managehome => true,
      groups     => $os_admin_group,
      password   => '!!',
      require    => Group['sysadm'];

    'sysop':
      ensure     => present,
      uid        => '501',
      gid        => 'sysop',
      comment    => 'System Operator',
      home       => '/home/sysop',
      shell      => '/bin/bash',
      managehome => true,
      password   => '!!',
      require    => Group['sysop'];
  }

  file {
    '/home/sysadm/.bashrc':
      ensure  => present,
      mode    => 644,
      owner   => sysadm,
      group   => sysadm,
      content => template('common/etc/user/bashrc.erb');

    '/home/sysadm/.bash_aliases':
      ensure  => present,
      mode    => 644,
      owner   => sysadm,
      group   => sysadm,
      content => template('common/etc/user/bash_aliases.erb');

    '/home/sysop/.bashrc':
      ensure  => present,
      mode    => 644,
      owner   => sysop,
      group   => sysop,
      content => template('common/etc/user/bashrc.erb');

    '/home/sysop/.bash_aliases':
      ensure  => present,
      mode    => 644,
      owner   => sysop,
      group   => sysop,
      content => template('common/etc/user/bash_aliases.erb');
  }
}
