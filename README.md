# local_users

[![Build Status](https://travis-ci.org/thbe/puppet-local_users.png?branch=master)](https://travis-ci.org/thbe/puppet-local_users)
[![Puppet Forge](https://img.shields.io/puppetforge/v/thbe/local_users.svg)](https://forge.puppetlabs.com/thbe/local_users)
[![Coverage Status](https://coveralls.io/repos/thbe/puppet-local_users/badge.svg?branch=master&service=github)](https://coveralls.io/github/thbe/puppet-local_users?branch=master)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with local_users](#setup)
    * [What local_users affects](#what-local_users-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with local_users](#beginning-with-local_users)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manage local user accounts.

## Module Description

With this module you can manage your local users as well as the root account.

## Setup

### What local_users affects

* Create specified users.

### Beginning with local_users

Simply include the class and specify one ore more users that should be created.

## Usage

```puppet
class { 'local_users':
  users => {
    'john' => { 'comment' => 'John Doe', 'shell' => '/bin/bash',  'password' => '!!' },
    'jane' => { 'comment' => 'Jane Doe', 'home'  => '/home/jane', 'groups'   => 'wheel' }
  },
}
```

## Reference

## Limitations

This module has been built on and tested against Puppet 4.0 and higher.

The module has been tested on:

* RedHat Enterprise Linux 5/6/7
* Scientific Linux 5/6/7
* CentOS Linux 5/6/7
* Oracle Enterprise Linux 5/6/7

Testing on other platforms has been light and cannot be guaranteed.

##Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.
