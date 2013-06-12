#
# Required repositories.
#
class yumrepos {
  package { 'yum-plugin-priorities':
    ensure => installed,
  }

  yumrepo {
    #"lcgdm-cbuild":
        #baseurl  => "http://grid-deployment.web.cern.ch/grid-deployment/dms/lcgdm/repos/el$operatingsystemmajrelease/\$basearch",
        #descr    => "LCGDM Continuous Builds",
        #enabled  => 0,
        #gpgcheck => 0,
        #protect  => 1;
    "slc6-os":
      descr    => "Scientific Linux CERN ${operatingsystemmajrelease} (SLC${operatingsystemmajrelease}) base system packages",
      baseurl  => "http://linuxsoft.cern.ch/cern/slc${operatingsystemmajrelease}X/\$basearch/yum/os/",
      gpgcheck => 0,
      enabled  => 1,
      protect  => 1;
    "slc6-updates":
      descr    => "Scientific Linux CERN ${operatingsystemmajrelease} (SLC${operatingsystemmajrelease}) bugfix and security updates",
      baseurl  => "http://linuxsoft.cern.ch/cern/slc${operatingsystemmajrelease}X/\$basearch/yum/updates/",
      gpgcheck => 0,
      enabled  => 1,
      protect  => 1;
    "slc6-extras":
      descr    => "Scientific Linux CERN ${operatingsystemmajrelease} (SLC${operatingsystemmajrelease}) add-on packages",
      baseurl  => "http://linuxsoft.cern.ch/cern/slc${operatingsystemmajrelease}X/\$basearch/yum/extras/",
      gpgcheck => 0,
      enabled  => 1,
      protect  => 1;
    "slc6-cernonly":
      descr    => "Scientific Linux CERN ${operatingsystemmajrelease} (SLC${operatingsystemmajrelease}) CERN-only packages",
      baseurl  => "http://linuxsoft.cern.ch/onlycern/slc${operatingsystemmajrelease}X/\$basearch/yum/cernonly/",
      gpgcheck => 0,
      enabled  => 0,
      protect  => 1;
    "epel":
      descr    => "Extra Packages for Enterprise Linux add-ons",
      baseurl  => "http://linuxsoft.cern.ch/epel/${operatingsystemmajrelease}/\$basearch",
      gpgcheck => 0,
      enabled  => 1,
      priority => 1,
      protect  => 1;
    "epel-testing":
      descr    => "Extra Packages for Enterprise Linux add-ons, testing",
      baseurl  => "http://linuxsoft.cern.ch/epel/testing/${operatingsystemmajrelease}/\$basearch",
      gpgcheck => 0,
      enabled  => 1,
      priority => 99,
      protect  => 1;
    "cvmfs":
      descr    => "CVMFS yum repository for Enterprise Linux",
      baseurl  => "http://cern.ch/cvmrepo/yum/cvmfs/EL/${operatingsystemmajrelease}/${architecture}",
      gpgcheck => 1,
      gpgkey   => 'https://cvmrepo.web.cern.ch/cvmrepo/yum/RPM-GPG-KEY-CernVM',
      enabled  => 1,
      priority => 1,
      protect  => 1;
    "cvmfs-testing":
      descr    => "CVMFS yum repository for Enterprise Linux, testing",
      baseurl  => "http://cern.ch/cvmrepo/yum/cvmfs-testing/EL/${operatingsystemmajrelease}/${architecture}",
      gpgcheck => 1,
      gpgkey   => 'https://cvmrepo.web.cern.ch/cvmrepo/yum/RPM-GPG-KEY-CernVM',
      enabled  => 1,
      priority => 99,
      protect  => 1;
    "htcondor":
      descr => "HTCondor Stable RPM Repository for Redhat Enterprise Linux ${operatingsystemmajrelease}",
      baseurl => "http://research.cs.wisc.edu/htcondor/yum/stable/rhel${operatingsystemmajrelease}",
      enabled => 1,
      gpgcheck => 0,
      priority => 1,
      protect  => 1;
    "htcondor-development":
      descr => "HTCondor Development RPM Repository for Redhat Enterprise Linux ${operatingsystemmajrelease}",
      baseurl => "http://research.cs.wisc.edu/htcondor/yum/development/rhel${operatingsystemmajrelease}",
      enabled => 1,
      gpgcheck => 0,
      priority => 99,
      protect  => 1;
  }
}

class { 'yumrepos': }
