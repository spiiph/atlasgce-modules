# module; shoal
#
# Installes, Configures and executes shoal client on RHEL.  Presumed installed on
# CernVM, it is installed over yum for RHEL.
#
# Parameters:
#    - server: shoal server to connect to
#    - cvmfs_config: cernvmfs configuration file to insert proxies to

class shoal (
  $server = 'http://shoal.heprc.uvic.ca/nearest',
  $cvmfs_config = '/etc/cvmfs/default.local'
)
{

  # Install shoal-client
  if $osvariant == 'CernVM' {
    
    info('On CernVM, assuming shoal is installed.')
    
  } elsif $osfamily == 'RedHat' {
  
    file {'shoal.repo':
      path    => '/etc/yum.repos.d/shoal.repo',
      ensure  => present,
      mode    => 0666,
      source => 'puppet:///modules/shoal/shoal.repo',
    }
    
    package {'shoal-client':
      ensure => installed,
    }
    
  }

  # configure shoal-client
  file {'/etc/shoal/shoal_client.conf':
    ensure => present,
    mode => 0644,
    content => template("shoal/shoal_client.conf.erb"),
  }

  exec {'/usr/bin/shoal-client':
    require => [ File['/etc/shoal/shoal_client.conf'],
                 File[$cvmfs_config] ],
  }
  
}
