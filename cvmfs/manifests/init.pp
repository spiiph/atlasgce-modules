# Class: cvmfs
#
#  This is a base installation of cvmfs
#
#  CVMFS is ...
#
# Parameters:
#    $user: CVMFS user
#    $group: CVMFS group
#    $cachedir: CVMFS cache directory
#    $homedir: CVMFS user home directory
#    $rundir: CVMFS run directory
#    $logdir: CVMFS log dir
#
# Actions:
#   - installs cvmfs
#   - setup cvmfs
#
# Requires:
#   - This has been tested on CentOS6
#

class cvmfs (
    $user = 'cvmfs',
    $group = 'cvmfs',
    $cachedir = '/var/cache/cvmfs2',
    $homedir = '/var/lib/cvmfs',
    $logdir = '/var/log/cvmfs',
    $rundir = '/var/run/cvmfs',
)
{
  include yumrepos

  package { ['cvmfs', 'cvmfs-init-scripts', 'cvmfs-keys', 'fuse', 'fuse-libs']:
    ensure => installed,
    require => Yumrepo[cvmfs],
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
    comment => 'CernVM-FS service account',
    managehome => true,
    system => true,
    require => Group['cvmfs'],
  }

  file { 'cachedir':
    ensure => 'directory',
    path => $cachedir,
    owner => $user,
    group => $group,
    require => [Group['cvmfs'], User['cvmfs']],
  }

  file { 'logdir':
    ensure => 'directory',
    path => $logdir,
    owner => $user,
    group => $group,
    require => [Group['cvmfs'], User['cvmfs']],
  }
}
