# class: gce_node
#
#  The gce_node class is an umbrella class for the cvmfs, xrootd, condor, and
#  APF services on an ATLAS analysis node running in GCE.
#
# Parameters:
#   - $head: FQDN of Condor Central Manager and XRootD redirector
#   - $role: Role of this node (head or worker)
#   - $condor_pool_password: Condor pool password
#   - $condor_slots: Number of job slots in the cluster and unique analysis
#                    accounts
#   - $xrootd_global_redirector: Address of the global XRootD redirector
#
# Actions:
#   - Installs extra packages from SLC6, CERN EPEL, and other repositories
#   - Configures the CVMFS, XRootD, Condor, and APF services
#
# Requires:
#   - This has been tested on CentOS6
#
# Author: Henrik Öhman <ohman@cern.ch>

class gce_node (
  $head,
  $role,
  $condor_pool_password,
  $condor_slots,
  $xrootd_global_redirector
){

  class { 'gce_node::packages':
    install_32bit_packages => false,
    install_slc6_packages => false,
  }

  class { 'gce_node::grid_setup': }

  class { 'cvmfs::client':
    repositories => 'atlas.cern.ch,atlas-condb.cern.ch',
  }

  class { 'xrootd::client':
    redirector => $head,
    role => $role,
    global_redirector => $xrootd_global_redirector,
  }

  class { 'condor::client':
      head => $head,
      role => $role,
      password => $condor_pool_password,
      slots => $condor_slots,
  }
}

