class gce_node::context_helper{

  file {'/tmp/setup.py':
    ensure => file,
    source => "puppet:///modules/gce_node/setup.py",
  }

  file {'/tmp/contexthelper':
    source => "puppet:///modules/gce_node/contexthelper",
    mode => 0755,
  }

  file {'/tmp/context':
    source => "puppet:///modules/gce_node/context",
    mode => 0755,
  }

  exec {'context_installer':
    command => 'python /tmp/setup.py install',
    require => [File['/tmp/setup.py'],File['/tmp/contexthelper'],File['/tmp/context']],
    creates => "/etc/init.d/context",
    path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    cwd => '/tmp',
  }

  file {'/etc/init.d/context':
    ensure => file,
    owner => root,
    group => root,
    mode => 0755,
    require => Exec['context_installer'],
  }

  file {'/usr/bin/contexthelper':
    ensure => file,
    source => "puppet:///modules/gce_node/contexthelper",
    owner => root,
    group => root,
    mode => 0755,
    require => Exec['context_installer'],
  }

  service {'context':
    require => [File['/etc/init.d/context'],File['/usr/bin/contexthelper']],
    ensure => running,
    enable => true,
    provider => init,
    before => [Class['condor::client'],Class['storage']],
  }
  
}
