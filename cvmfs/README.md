# cvmfs
## Description

The *cvmfs* module manages the [CernVM-FS](http://cernvm.cern.ch/portal/filesystem) configuration.

## Operating system support

Software package installation is only supported on RedHat based system, but the configuration should work everywhere. _Note: On CernVM CernVM-FS is already configured and it is not recommended to use this module._

## Contents

The *cvmfs* module does the following:

* Installs the CernVM-FS package (if supported)
* Creates the `cvmfs` user and group and necessary directories
* Clobbers `/etc/fuse.conf`
* _"Instantiates"_ the *autofs* module with the `/cvmfs` mount point
* Writes the CernVM-FS configuration to `/etc/cvmfs/default.local`

## Variables and defaults

Here are some notable variables and their default values:

<table>
  <tr><td>`repositories`</td><td>Comma separated list of CernVM-FS repositories</td><td>_None_</td></tr>
  <tr><td>`squidproxy`</td><td>Comma separated list of squid proxies</td><td>`undef`</td></tr>
  <tr><td>`quota`</td><td>Quota in MB</td><td>`undef`</td></tr>
  <tr><td>`debug`</td><td>Turn on debug logging</td><td>`undef`</td></tr>
</table>
