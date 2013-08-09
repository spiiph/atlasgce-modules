# Class: apf::client
#
#  AutoPyFactory is a pilot factory to create PanDA pilots.
#  https://www.racf.bnl.gov/experiments/usatlas/griddev/AutoPyFactory
#
#  This is the configuration for an ATLAS Tier 3 head/worker node. It is made
#  up of ...
#
# Parameters:
#   - $panda_site: The name of the panda site
#   - $panda_site: The name of the panda queue
#   - $panda_cloud: The PanDA Cloud this site belongs to
#   - $panda_grid: The PanDA Grid this site belongs to
#   - $panda_vo: The virtual organization this site belongs to
#   - $panda_country: The country in which this site is located
#   - $http_server_address: The address of the http server serving logs etc.
#   - $factory_id: Unique name for this pilot factory
#   - $admin_email: Email address of the site administrator
#   - $monitor_url: URL to the PanDA monitor page for this site
#
# Actions:
#   - prepares configuration files for APF
#   - starts the factory service
#
# Requires:
#   - This has been tested on CentOS6
#
# Author: Henrik Öhman <ohman@cern.ch>
# Based on prior work by Val Hendrix <vchendrix@lbl.gov> (US Atlas Tier 3
# Puppet modules)

class apf::client (
  $panda_site,
  $panda_queue,
  $panda_cloud,
  $panda_grid = 'EGI',
  $panda_vo = 'ATLAS',
  $factory_id,
  $admin_email,
  $http_server_address,
  $scriptdir = '/usr/libexec/apf',
  $wrapper = 'wrapper.sh',
  $grid_setup = 'apf-grid-setup.sh',
  $use_emi_grid_software = true,
  $sysconfig = '/etc/sysconfig/factory.sysconfig',
  $factory_config = '/etc/apf/factory.conf',
  $proxy_config = '/etc/apf/proxy.conf',
  $queues_config = '/etc/apf/queues.conf',
  $monitor_config = '/etc/apf/monitor.conf',
) inherits apf
{
  file { $scriptdir:
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  $wrapper_path = "$scriptdir/$wrapper"
  file { $wrapper_path:
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => 755,
    source => 'puppet:///modules/apf/wrapper.sh',
    require => File[$scriptdir],
  }

  $grid_setup_path = "$scriptdir/$grid_setup"
  file { $grid_setup_path:
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => 755,
    content => template('apf/apf-grid-setup.sh.erb'),
    require => File[$scriptdir],
  }

  file { $sysconfig:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('apf/sysconfig.erb'),
    require => Class['apf']
  }

  file { $factory_config:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('apf/factory.conf.erb'),
    require => Class['apf']
  }

  file { $proxy_config:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('apf/proxy.conf.erb'),
    require => Class['apf']
  }

  file { $queues_config:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('apf/queues.conf.erb'),
    require => Class['apf']
  }

  file { $monitor_config:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('apf/monitor.conf.erb'),
    require => Class['apf']
  }

  service { 'factory':
    ensure => running,
    subscribe => File[$factory_config, $proxy_config, $queues_config,
                    $monitor_config, $sysconfig, $wrapper_path, $grid_setup_path],
  }
}
