# Class: cvmfs::repo
#
#  "custom" modules implies that the administrator must supply the files in a custom directory called
#  $moduleFilesMount
#
#
# Parameters:
#   - $moduleFilesMount - mount point for the module files
#
# Actions:
#   - creates /etc/cvmfs/config.d/$name.local and /opt/split($name, '.')[0]
#
#
# Requires:
#   - This has been tested on SL and SLC 5.5
#   - mount point $moduleFilesMount defined in the fileserver.confg with the following files
#   - $name is the name assigned to the definition
#       file: $moduleFilesMount/cvmfs/config.d/$name.local
#
class cvmfs::repo(
    $repositories,
    $squidproxy = undef,
    $quota = undef
) inherits cvmfs
{
}

class cvmfs::repo($moduleFilesMount="/module-files") {

    $namesplit=split($name, '[.]')
    file { "/etc/cvmfs/config.d/$name.local":
        ensure => present,
        mode => 0644,
        owner => "root",
        group => "root",
        require => Package["cvmfs"],
        source => "puppet://$moduleFilesMount/cvmfs/config.d/$name.local",
        notify => Service['cvmfs'],
    }

    $link = $namesplit[0]
    file { "/opt/$link":
         ensure => "/cvmfs/$name",
         notify => Service['cvmfs'],
    }

}
