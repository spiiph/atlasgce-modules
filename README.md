# atlasgce-modules
## Description

The [atlasgce-modules](https://github.com/spiiph/atlasgce-modules "atlasgce-modules") are  Puppet modules for contextualizing [ATLAS](http://atlas.ch/) analysis clusters. They are developed primarily for [Google Compute Engine (GCE)](https://cloud.google.com/products/compute-engine).

## Detailed documentation

See the documentation in each subdirectory for detailed information about each module.

## Operating system support

The modules have been tested on the [CentOS 6](http://www.centos.org/) operating system. It should work out of the box for most [RedHat](http://www.redhat.com/) based systems of the same generation, such as [SL6](https://www.scientificlinux.org/) and [SLC6](http://linux.web.cern.ch/linux/scientific6/).

Work is also in progress to partially support [CernVM](http://cernvm.cern.ch/). The SLC5 based CernVM 2.6 and 2.7 will have support for all modules except `packagerepos` (due to lack of Conary support in Puppet) and `cvmfs` (which is already configured during the CernVM contextualization). [μCernVM](http://cernvm.cern.ch/portal/ucernvm) will be SLC6 based and use RPM for package management, and should be fully supported.

[Debian](http://www.debian.org/) based systems are not supported, but can be implemented upon request.

## Cloud support

These modules have been developed for GCE, but support for other clouds can be impemented upon request.

# Functionality
## Overview

The [atlasgce-modules](https://github.com/spiiph/atlasgce-modules "atlasgce-modules") provide from-scratch contextualization on bare instances (virtual or physical) for analysis for the [ATLAS Experiment](http://atlas.ch).

Three different instance roles are available: The manager role (`head`), the worker role (`node`), and the worker role for a [Cloud Scheduler](http://cloudscheduler.org/) environment (`csnode`).

## The manager role (`head`)

The manager role consists of the following elements:

* The [AutoPyFactory](https://svnweb.cern.ch/trac/panda/browser/panda-autopyfactory) service fetches jobs from a PanDA queue and submits them locally to Condor.
* The [Condor](http://research.cs.wisc.edu/htcondor/) submit and collector services manage the distribution of subjobs over the worker nodes.
* The [XRootD](http://xrootd.slac.stanford.edu/) XRootD and Cluster Management services act as a local XRootD redirector and are responsible for accessing and caching input data files through the [Federated ATLAS XRootD system](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/AtlasXrootdSystems). (Optional)
* The [CernVM-FS](http://cernvm.cern.ch/portal/filesystem) service provides consistent access to ATLAS software. CernVM-FS is not strictly required for the manager role, but can be used for debugging the Condor services. (Optional)
* [Compatibility packages](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/RPMCompatSLC6) for running SLC5 binaries on SLC6.

## The worker role (`node`)

The node role consists of the following elements:

* The [Condor](http://research.cs.wisc.edu/htcondor/) startd service runs the individual subjobs as directed by the manager.
* The [XRootD](http://xrootd.slac.stanford.edu/) XRootD, Cluster Management, and File Residency Management services are responsible for accessing input data files through the manager and download those that are not yet available in the cache.
* The [CernVM-FS](http://cernvm.cern.ch/portal/filesystem) service provides consistent access to ATLAS software.
* [Compatibility packages](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/RPMCompatSLC6) for running SLC5 binaries on SLC6.

## The Cloud Scheduler worker role (`csnode`)
The Cloud Scheduler worker role consists of the following elements:

* The [Condor](http://research.cs.wisc.edu/htcondor/) startd service runs the individual subjobs as directed by the Cloud Scheduler instance.
* The [CernVM-FS](http://cernvm.cern.ch/portal/filesystem) service provides consistent access to ATLAS software.
* [Compatibility packages](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/RPMCompatSLC6) for running SLC5 binaries on SLC6.

# Contextualization

The contextualization of the instances is governed by [Puppet](http://puppetlabs.com/) through the means of a public collection of modules (the `atlasgce-modules`) and one or more scripts for bootstrapping.

## Bootstrapping

The standard way of bootstrapping GCE images is to use a [startup script](https://developers.google.com/compute/docs/howtos/startupscript).

For Cloud Scheduler worker nodes startup scripts are not supported, and bootstrapping is instead achieved using a machine image that is prepared with a script that downloads and runs a script supplied through the `userdata` metadata attribute. (In the future Cloud Scheduler might support startup scripts on GCE.)

See spiiph/atlasgce-scripts for more information on the bootstrapping procedure.

## What is contextualized?

The `atlasgce-modules` in combination with the bootstrapping procedure handles contextualization of everything from preparing and mounting additional storage, to add package repositories and download required software, to create and setup user accounts for services, and to configure and start the supported services.

This contextualization is done from a bare instance, meaning that no software other than [Yum](http://yum.baseurl.org/) is required. Even Puppet is installed during the bootstrapping procedure. (Note: This does not apply to CernVM, whose package manager Conary is not supported.)

This means that the extra work of preparing machine images with the required software and configurations, with the rather high turn-around time that comes with it, is basically abolished. The extra cost of redoing the contextualization at instantiation has been found to be very small (tested on GCE only.)

## Puppet

See [What is Puppet?](https://puppetlabs.com/puppet/what-is-puppet/)

# Contents
## packagerepos

Module to manage extra package repositories for Scienfic Linux CERN, CERN EPEL, CernVM-FS, Condor, and APF.

autofs and cvmfs
----------------

Module to manage the CernVM-FS configuration and the autofs service.

xrootd
------

Module to manage the XRootD, Cluster Management, and File Residency Management configuration and services.

condor
------

Module to manage the HT Condor configuration and services.

gce_node
--------

Umbrella module to set up a VM on GCE to be either a head node or a worker node.

