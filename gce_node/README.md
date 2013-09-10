# gce_node
## Description

The *gce_node* module is an umbrella module that collects the configuration of the services for the different roles in one place.

## Operating system support

Software package installation is only supported on RedHat based system, but the configuration should work everywhere.

## Contents

The *gce_node* module does the following:

* Installs compatibility packages for running SLC5 binaries on SLC6
* Writes the grid setup profile to `/etc/profile.d/grid-setup.sh`
* Sets up the [cvmfs](https://github.com/spiiph/atlasgce-modules/tree/master/autofs) module with `repositories => 'atlas.cern.ch,atlas-condb.cern.ch'`
* Sets up the [xrootd](https://github.com/spiiph/atlasgce-modules/tree/master/xrootd) module
* Sets up the [condor](https://github.com/spiiph/atlasgce-modules/tree/master/condor) module
* Sets up the [apf](https://github.com/spiiph/atlasgce-modules/tree/master/apf) module (`head` role)

## Variables and defaults

Here are some notable variables and their default values:

<table>
  <tr><td>`head`</td><td>The manager node of the cluster</td><td>_None_</td></tr>
  <tr><td>`role`</td><td>The role of this node</td><td>_None_</td></tr>
  <tr><td>`use_cvmfs`</td><td>Use the *cvmfs* module</td><td>`true`</td></tr>
  <tr><td>`condor_password`</td><td>Condor pool password</td><td>`undef`</td></tr>
  <tr><td>`condor_use_gsi`</td><td>Turn on GSI security</td><td>`false`</td></tr>
  <tr><td>`condor_slots`</td><td>Condor slots per machine (&le; #CPUs)</td><td>_None_</td></tr>
  <tr><td>`use_xrootd`</td><td>Use the *xrootd* module</td><td>`true`</td></tr>
  <tr><td>`xrootd_global_redirector`</td><td>XRootD redirector for external requests</td><td>`undef`</td></tr>
  <tr><td>`atlas_site`</td><td>The ATLAS site name, as used in the grid setup</td><td>`undef`</td></tr>
  <tr><td>`use_apf`</td><td>Use the *apf* module</td><td>`true`</td></tr>
  <tr><td>`panda_site`</td><td>The PanDA site name</td><td>_None_</td></tr>
  <tr><td>`panda_queue`</td><td>The PanDA queue name</td><td>_None_</td></tr>
  <tr><td>`panda_cloud`</td><td>The PanDA cloud that the site belongs to</td><td>_None_</td></tr>
  <tr><td>`panda_adminstrator_email`</td><td>Administrator email for APF</td><td>_None_</td></tr>
  <tr><td>`http_server_address`</td><td>HTTP server address for logs</td><td>_None_</td></tr>
  <tr><td>`debug`</td><td>Turn on debug logging</td><td>`undef`</td></tr>
</table>

