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
  $condor_pool_password = undef,
  $condor_use_gsi = false,
  $condor_slots,
  $use_xrootd = true,
  $xrootd_global_redirector = undef,
  $atlas_site,
  $use_apf = true,
  $panda_site = undef,
  $panda_queue = undef,
  $panda_cloud = undef,
  $panda_administrator_email = undef,
  $debug = false
){

  class { 'gce_node::packages':
    install_32bit_packages => false,
    install_slc6_packages => false,
  }

  class { 'gce_node::grid_setup':
    atlas_site => $atlas_site,
  }

  class { 'cvmfs::client':
    repositories => 'atlas.cern.ch,atlas-condb.cern.ch',
    debug => $debug,
  }

  if $use_xrootd == true {
    class { 'xrootd::client':
      redirector => $head,
      role => $role,
      global_redirector => $xrootd_global_redirector,
      debug => $debug,
    }
  }

  class { 'condor::client':
      head => $head,
      role => $role,
      password => $condor_pool_password,
      use_gsi_security => $condor_use_gsi,
      slots => $condor_slots,
      debug => $debug,
  }

  if $role == 'head' and $use_apf == true {
    class { 'apf::client':
      panda_site => $panda_site,
      panda_queue => $panda_queue,
      panda_cloud => $panda_cloud,
      factory_id => 'atlasgce_factory',
      admin_email => $panda_administrator_email,
      http_server_address => gce_metadata_query('instance/network-interfaces/0/access-configs/0/external-ip'),
      debug => $debug,
    }
  }
}
