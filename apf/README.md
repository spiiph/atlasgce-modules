# apf
## Description

The `apf` module manages the configuration and services for [AutoPyFactory](https://svnweb.cern.ch/trac/panda/browser/panda-autopyfactory).

## Operating system support

Software package installation is only supported on RedHat based system, but the configuration should work everywhere.

## Contents

The `apf` module does the following:

* Installs the AutoPyFactory package
* Creates the `apf` user and group and necessary directories
* Writes the AutoPyFactory job wrapper script to `/usr/libexec/apf/wrapper.sh`
* Writes the grid setup script to `/usr/libexec/apf/apf-grid-setup.sh`
* Writes the sysconfig to `/etc/sysconfig/factory.sysconfig`
* Writes the configuration files `factory.conf`, `proxy.conf`, `queues.conf`, and `monitor.conf` to `/etc/apf`
* Starts the AutoPyFactory service

## Variables and defaults

Here are some notable variables and their default values:

<table>
  <tr><td>`panda_site`</td><td>The PanDA site name</td><td>_None_</td></tr>
  <tr><td>`panda_queue`</td><td>The PanDA queue name</td><td>_None_</td></tr>
  <tr><td>`panda_cloud`</td><td>The PanDA cloud that the site belongs to</td><td>_None_</td></tr>
  <tr><td>`panda_grid`</td><td>The PanDA grid type</td><td>`EGI`</td></tr>
  <tr><td>`panda_vo`</td><td>Virtual organisation for PanDA</td><td>`ATLAS`</td></tr>
  <tr><td>`factory_id`</td><td>Unique ID string for this factory</td><td>_None_</td></tr>
  <tr><td>`admin_email`</td><td>Administrator email</td><td>_None_</td></tr>
  <tr><td>`http_server_address`</td><td>HTTP server address for logs</td><td>_None_</td></tr>
  <tr><td>`use_emi_grid_software`</td><td>Use EMI (`true`) or gLite (`false`) grid software</td><td>`true`</td></tr>
  <tr><td>`debug`</td><td>Turn on debug logging</td><td>`undef`</td></tr>
</table>
