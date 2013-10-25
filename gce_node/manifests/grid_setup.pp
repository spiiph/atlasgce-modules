class gce_node::grid_setup (
  $atlas_site = undef,
  $use_gridftp2 = false,
  $use_emi_grid_software = true,
  $setup_file = '/etc/profile.d/grid-setup.sh',
  $security_dir = '/etc/grid-security'
)
{
  file { $setup_file:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('gce_node/grid-setup.sh.erb'),
  }

  if $gce_node::role == 'csnode' {
    file { $security_dir:
      ensure => directory,
      owner => root,
      group => root,
      mode => 0755,
    }
    
    file { 'hostcert.pem':
      path => "${security_dir}/hostcert.pem",
      ensure => present,
      owner => root,
      group => root,
      mode => 0644,
      require => File[$security_dir],
    }

    file { 'hostkey.pem':
      path => "${security_dir}/hostkey.pem",
      ensure => present,
      owner => root,
      group => root,
      mode => 0600,
      require => File[$security_dir],
    }
    
    file { 'certificates':
      path => "${security_dir}/certificates",
      ensure => directory,
      owner => root,
      group => root,
      mode => 0755,
      require => File[$security_dir],
    }

  }
  
}

