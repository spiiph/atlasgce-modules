# class: condor::client
#
#  Condor is a specialized workload management system for compute-intensive
#  jobs. Like other full-featured batch systems, Condor provides a job
#  queueing mechanism, scheduling policy, priority scheme, resource
#  monitoring, and resource management.  Users submit their serial or
#  parallel jobs to Condor, Condor places them into a queue, chooses when and
#  where to run the jobs based upon a policy, carefully monitors their
#  progress, and ultimately informs the user upon completion.
#
#  This is the configuration for an ATLAS Tier 3 head/worker node. It is made
#  up of ...
#
# Parameters:
#   - $head: FQDN of Condor Central Manager
#   - $role: Role of this node (node, collector, submit)
#   - $password: Condor pool password
#   - $slots: Number of worker slots for each node
#   - $node_type: Determines what job types this node should accept
#   - $password_file: Path to pool password file
#   - $config: Path to condor_config.local file
#   - $job_wrapper: Path to job wrapper script
#
# Actions:
#   - prepares configuration files for Condor
#   - starts the condor service
#
# Requires:
#   - This has been tested on CentOS6
#
# Author: Henrik Öhman <ohman@cern.ch>
# Based on prior work by Val Hendrix <vchendrix@lbl.gov> (US Atlas Tier 3
# Puppet modules) and John Hover <jhover@bnl.gov> (Scalable Condor setup for
# clouds)


class condor::client(
  $head,
  $role,
  $password = undef,
  $slots = 32,
  $collectors = undef,
  $node_type = undef,
  $password_file = "$homedir/pool_password",
  $use_gsi_security = false,
  $config = '/etc/condor/condor_config.local',
  $sysconfig = undef,
  $job_wrapper = '/usr/libexec/condor/jobwrapper.sh',
  $debug = undef
) inherits condor
{

  if $role == 'node' or $role == 'csnode' {
    # Create an user account for each condor slot
    $user_array = condor_user_array($slots)
    condor_user { $user_array: }
  }

  file { $config:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template("condor/condor_config.local.${role}.erb"),
    require => Class['condor'],
  }

  if $password {
    exec { pool_password:
      command => "/usr/sbin/condor_store_cred -c add -p $password -f $password_file",
      require => File[$config],
      creates => $password_file,
      notify => Service['condor'],
    }

    file { $password_file:
      ensure => present,
      owner => 'root',
      group => 'root',
      mode => 0600,
      require => Exec[pool_password],
    }
  }

  file { $job_wrapper:
    owner => 'root',
    group => 'root',
    mode => 0755,
    source => 'puppet:///modules/condor/jobwrapper.sh',
    require => Class['condor'],
  }

  # Change the init.d script for the CloudScheduler nodes, but don't start
  # the service
  if $role == 'csnode' {
    file { '/etc/init.d/condor':
      owner => 'root',
      group => 'root',
      mode => 0755,
      source => 'puppet:///modules/condor/condor.init.d',
      require => Class['condor'],
    }
  } else {
    if $password {
      $requires = [Exec[pool_password]]
    } else {
      $requires = []
    }
    service { 'condor':
      ensure => running,
      enable => true,
      subscribe => File[$config, $job_wrapper],
      require => $requires,
    }
  }
}

define condor_user ($user = $name, $group = $name) {
  group { $user:
    ensure => present,
  }

  user { $group:
    ensure => present,
    gid => $group,
    shell => '/bin/bash',
    managehome => true,
    require => Group[$group],
  }

  #notify { $user:
    #message => "Created user and group for $user",
    #require => User[$user],
  #}
}
