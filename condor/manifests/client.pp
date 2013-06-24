# class: condor::client
#
#  Condor is a ...
#
#  This is the configuration for an ATLAS Tier 3 head/worker node. It is made
#  up of ...
#
# Parameters:
#   - $head: FQDN of Condor Central Manager
#   - $role: Role of this node (node, collector, submit)
#   - $config: Path to condor_config.local file
#   - $password: Condor pool password
#   - $password_file: Path to pool password file
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
  $config = '/etc/condor/condor_config.local',
  $password = 'condor',
  $password_file = "$homedir/pool_password",
) inherits condor
{
  file { $config:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template("condor/condor_config.local.${role}.erb"),
    require => Class['condor'],
  }

  exec { pool_password:
    command => "condor_store_cred -c add -p $password -f $password_file",
    require => File[$config],
    creates => $password_file,
  }

  if ($role == 'worker')
  {
    file { '/usr/libexec/condor/jobwrapper.sh':
      owner => 'root',
      group => 'root',
      mode => 0755,
      source => "puppet:///modules/condor/jobwrapper.sh",
      notify => Service["condor"],
    }
  }

  service { "condor":
    ensure => running,
    enable => true,
    subscribe => File[$config],
    require => Exec[pool_password],
  }
}

