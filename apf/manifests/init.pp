# Class: apf
#
#  AutoPyFactory is a pilot factory to create PanDA pilots.
#  https://www.racf.bnl.gov/experiments/usatlas/griddev/AutoPyFactory
#
#  This is a base installation of AutoPyFactory
#
# Parameters:
#   - $user: APF user
#   - $group: APF group
#   - $homedir: APF homedir
#
# Actions:
#   - installs AutoPyFactory and sets up the APF user account
#
# Requires:
#   - This has been tested on CentOS6
#
# Author: Henrik Öhman <ohman@cern.ch>
# Based on prior work by Val Hendrix <vchendrix@lbl.gov> (US Atlas Tier 3
# Puppet modules)

class apf (
  $user = 'apf',
  $group = 'apf',
  $homedir = '/var/lib/apf',
  $logdir = '/var/log/apf',
){
  include yumrepos

  package { 'panda-autopyfactory':
    ensure => installed,
    require => Yumrepo[racf-grid-production],
  }

  group { $group:
    ensure => present,
    system => true,
  }

  user { $user:
    ensure => present,
    gid => $group,
    #shell => '/sbin/nologin',
    shell => '/bin/bash',
    home => $homedir,
    comment => 'AutoPyFactory service account',
    managehome => true,
    system => true,
    require => Group[$group],
  }

  file { $homedir:
    ensure => 'directory',
    owner => $user,
    group => $group,
    mode => 0755,
    require => [Group[$group], User[$user]],
  }

  file { $logdir:
    ensure => directory,
    owner => $user,
    group => $group,
    mode => 0755,
    require => [Group[$group], User[$user]],
  }
}
