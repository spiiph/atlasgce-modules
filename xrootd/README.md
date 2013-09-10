# xrootd
## Description

The *xrootd* module manages the configuration and services for [XRootD](http://xrootd.slac.stanford.edu/).

## Operating system support

Software package installation is only supported on RedHat based system, but the configuration should work everywhere.

## Contents

The *xrootd* module does the following:

* Installs the XRootD packages
* Creates the `xrootd` user and group and necessary directories
* Writes the system configuration to `/etc/sysconfig/xrootd`
* Writes the XRootD service configuration to `/etc/xrootd/xrootd.cfg`
* Writes the authentication configuration to `/etc/xrootd/auth_file`
* Starts the `xrootd` and `cmsd` services

If `role` is `node`, it also does the following:

* Creates the cache directories
* Writes the stage-in script to `/etc/xrootd/stagein.sh`
* Starts the `frm_xfrd` and `frm_purged` services

## Variables and defaults

Here are some notable variables and their default values:

<table>
  <tr><td>`redirector`</td><td>The manager node</td><td>_None_</td></tr>
  <tr><td>`role`</td><td>The role of this node</td><td>_None_</td></tr>
  <tr><td>`storage_path`</td><td>Storage path</td><td>`/atlas`</td></tr>
  <tr><td>`oss_localroot`</td><td>Local cache directory</td><td>`/data/scratch`</td></tr>
  <tr><td>`global_redirector`</td><td>Redirector for external requests</td><td>`atlas-xrd-eu.cern.ch`</td></tr>
  <tr><td>`xrdport`</td><td>Port for Xrd connections</td><td>`1094`</td></tr>
  <tr><td>`debug`</td><td>Turn on debug logging</td><td>`undef`</td></tr>
</table>
