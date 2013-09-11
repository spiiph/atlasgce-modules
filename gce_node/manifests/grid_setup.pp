class gce_node::grid_setup (
  $atlas_site = undef,
  $use_gridftp2 = false,
  $use_emi_grid_software = true,
  $setup_file = '/etc/profile.d/grid-setup.sh'
)
{
  file { $setup_file:
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('gce_node/grid-setup.sh.erb'),
    require => Class[cvmfs::client],
  }
}

