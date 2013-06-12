# Class: cvmfs::client
#
#  Manages the CVMFS configuration files and the CVMFS service
#
# Parameters:
#   - $repositories: CVMFS repos to mount
#   - $squidproxy: Addresses to squid proxies (if any)
#   - $quota: Quota limit
#   - $local_conf: Path to local.conf file
#
# Actions:
#   - creates /etc/cvmfs/default.conf
#   - #creates /etc/cvmfs/local.conf
#   - starts the cvmfs service
#
# Requires:
#   - The autofs module
#   - This has been tested on CentOS6
#
# Author: Val Hendrix <vchendrix@lbl.gov>
# Modified for GCE: Henrik Öhman <ohman@cern.ch>

class cvmfs::client(
    $repositories,
    $squidproxy = undef,
    $quota = undef,
    $local_conf = '/etc/cvmfs/default.local',
    $fuse_conf = '/etc/fuse.conf'
) inherits cvmfs
{
  class { autofs::client:
    mounts => {'cvmfs' => '/etc/auto.cvmfs'},
  }

  file { $local_conf:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('cvmfs/default.local.erb'),
    notify => Service[cvmfs],
  }

  # Clobber the /etc/fuse.conf, hopefully no
  # one else wants it.
  file{ $fuse_conf:
    ensure  => present,
    source  => 'puppet:///modules/cvmfs/fuse.conf',
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    notify  => Service[cvmfs],
  }

  service { 'cvmfs':
    enable => true,
    ensure => running,
    require => [Class[autofs::client, cvmfs]],
    subscribe =>  File[$local_conf, $fuse_conf, $autofs::client::master_conf],
  }
}
