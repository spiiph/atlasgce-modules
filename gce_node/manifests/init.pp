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
  $use_cvmfs = true,
  $condor_pool_password = undef,
  $condor_use_gsi = false,
  $condor_slots,
  $use_xrootd = true,
  $xrootd_global_redirector = undef,
  $cvmfs_domain_servers = undef,
  $use_apf = true,
  $panda_site = undef,
  $panda_queue = undef,
  $panda_cloud = undef,
  $panda_administrator_email = undef,
  $debug = false,
  $condor_vmtype = 'cernvm-batch-node-2.7.2-x86_64'
){

  class { 'gce_node::packages':
    install_32bit_packages => false,
    install_slc6_packages => false,
  }

  class { 'gce_node::grid_setup':
  }

  class {'gce_node::clock_setup':
  }

  if $use_cvmfs == true {
    class { 'cvmfs::client':
      repositories => 'atlas.cern.ch,atlas-condb.cern.ch,grid.cern.ch',
      squidproxy => 'http://chrysaor.westgrid.ca:3128;http://cernvm-webfs.atlas-canada.ca:3128',
      quota => 5000,
      debug => $debug,
      cvmfs_servers => $cvmfs_domain_servers,
    }
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
      vmtype => $condor_vmtype
  }

  if $osfamily == 'CernVM' {
    class { 'cernvm':
      cvmfs2       => 'on',
      edition      => 'Basic',
      organization => 'atlas',
      repositories => 'atlas,atlas-condb,grid',
    }
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

 if $role == 'csnode' {
    sysctl {'net.core.rmem_max': value => "16777216" }
    sysctl {'net.core.wmem_max': value => "16777216" } 
    sysctl {'net.ipv4.tcp_rmem': value => "4096 87380 16777216" }
    sysctl {'net.ipv4.tcp_wmem': value => "4096 65536 16777216" }
    sysctl {'net.core.netdev_max_backlog': value => "30000" }
    sysctl {'net.ipv4.tcp_timestamps': value => "1" }
    sysctl {'net.ipv4.tcp_sack': value => "1" }

    class {'storage':
      cloud_type => $cloud_type,
    }
  }

}
