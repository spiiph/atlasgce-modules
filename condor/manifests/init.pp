# Class: condor
#
#  This is a base installation of condor
#
#  Condor is a ...
#
# Parameters:
#
#
# Actions:
#   - installs condor
#
# Requires:
#   - This has been tested on CentOS6
#
# Author: Henrik Öhman <ohman@cern.ch>
# Based on prior work by Val Hendrix <vchendrix@lbl.gov> (US Atlas Tier 3
# Puppet modules) and John Hover <jhover@bnl.gov> (Scalable Condor setup for
# clouds)

class condor (
    $user = 'condor',
    $group = 'condor',
    $homedir = '/var/lib/condor',
){
  package { ['condor']:
    ensure => installed,
    require => Yumrepo[htcondor],
  }

  group { $group:
    ensure => present,
    system => true,
  }

  user { $user:
    ensure => present,
    gid => $group,
    shell => '/sbin/nologin',
    home => $homedir,
    comment => 'Owner of Condor Daemons',
    managehome => true,
    system => true,
    require => Group[$group],
  }

}
