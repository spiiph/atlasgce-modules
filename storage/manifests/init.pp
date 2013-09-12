# Class: storage
#
# This sets up the ephemereal partition for OpenStack or the blankspace partition for Nimbus
#
# Actions:
#   - create /scratch mount directory
#   - setup mount point
#
# Requires:
#   - Tested in CernVM on Nimbus
#

class storage(
  $cloud_type = 'OpenStack',
  $mountpoint = '/scratch'
)
{

  file {$mountpoint:
    ensure => directory,
  }
    
  
  if $cloud_type == 'OpenStack' {
    mount {$mountpoint:
      ensure  => 'present',
      device  => 'LABEL=ephemeral0',
      fstype  => 'ext4',
      options => 'noatime',
      dump    => 1,
      pass    => 0,
      require => File[$mountpoint],
    }
  }
  
  if $cloud_type == 'nimbus' {
    mount {$mountpoint:
      ensure  => 'present',
      device  => 'LABEL=blankpartition0',
      fstype  => 'ext2',
      options => 'noatime',
      dump    => 1,
      pass    => 0,
      require => File[$mountpoint],
    }
  }

}
