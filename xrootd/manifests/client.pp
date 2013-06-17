# class: xrootd::head
#
#  XrootD is a high performance network storage system widely used in high
#  energy physics experiments such as ATLAS and ALICE. The underlying Xroot
#  data transfer protocol provides highly efficient access to ROOT based data
#  files. This class provides the basis for creating a simple Xrootd storage
#  system consisting of one redirector node and one or more data server
#  nodes.
#
#  This is the configuration for an ATLAS Tier 3 head node. It has a
#  redirector and a data server.
#
# Parameters:
#   - $redirector: fully qualified domain name for the redirector
#   - $oss_localroot: Local root for the data server inventories
#   - $storage_path: Path for internal references
#   - $config: XrootD config file path
#   - $sysconfig: XrootD system configuration file path
#
# Actions:
#   - sets up the storage directories, prepares configuration files for
#     xrootd and the the simple storage inventory
#   - starts the xrootd and cmsd services
#
# Requires:
#   - This has been tested on CentOS6
#
# Author: Val Hendrix <vchendrix@lbl.gov>
# Modified for GCE: Henrik Öhman <ohman@cern.ch>

class xrootd::client (
  $redirector,
  $storage_path = '/atlas',
  $oss_localroot = '/data/scratch',
  $global_redirector = 'atlas-xrd-eu.cern.ch',
  $xrdport = 1094,
  $trace = undef,
  $config = '/etc/xrootd/xrootd.cfg',
  $sysconfig = '/etc/sysconfig/xrootd',
  $auth_file = '/etc/xrootd/auth_file',
  $stagein = '/etc/xrootd/stagein.sh'
  ) inherits xrootd
{
  file { $sysconfig:
    owner => 'root',
    group => 'root',
    ensure  => present,
    content => template('xrootd/xrootd.sysconfig.erb'),
    require => Class['xrootd'],
  }

  file { $config:
    owner => $user,
    group => $group,
    ensure  => present,
    content => template('xrootd/xrootd.cfg.erb'),
    require => Class['xrootd'],
  }

  file { $auth_file:
    owner => $user,
    group => $group,
    ensure => present,
    content => template('xrootd/auth_file.erb'),
    require => Class['xrootd'],
  }

  file { $stagein:
    owner => $user,
    group => $group,
    mode => 0755,
    ensure => present,
    content => template('xrootd/stagein.sh.erb'),
    require => Class['xrootd'],
  }

  file { [$oss_localroot, "$oss_localroot$storage_path"]:
    owner => $user,
    group => $group,
    ensure => directory,
    recurse => true,
    require => Class['xrootd'],
  }

  # Start the xrootd service
  service { 'xrootd':
    ensure => running,
    enable => true,
    subscribe => File[$sysconfig, $config],
    require => File["$oss_localroot$storage_path"],
   }

  # Start the cmsd service
  service { 'cmsd':
    ensure => running,
    enable => true,
    subscribe => File[$sysconfig, $config],
    require => File["$oss_localroot$storage_path"],
   }

  service { 'frm_xfrd':
    ensure => running,
    enable => true,
    subscribe => File[$sysconfig, $config],
    require => File["$oss_localroot$storage_path"],
   }

  service { 'frm_purged':
    ensure => running,
    enable => true,
    subscribe => File[$sysconfig, $config],
    require => File["$oss_localroot$storage_path"],
   }
}
