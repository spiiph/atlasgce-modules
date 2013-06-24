# Class: condor
#
#  Condor is a specialized workload management system for compute-intensive
#  jobs. Like other full-featured batch systems, Condor provides a job
#  queueing mechanism, scheduling policy, priority scheme, resource
#  monitoring, and resource management.  Users submit their serial or
#  parallel jobs to Condor, Condor places them into a queue, chooses when and
#  where to run the jobs based upon a policy, carefully monitors their
#  progress, and ultimately informs the user upon completion.
#
#  This is a base installation of condor.
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
  include yumrepos

  package { 'condor':
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
