# apf
## Description

The *apf* module manages the configuration and services for [AutoPyFactory](https://svnweb.cern.ch/trac/panda/browser/panda-autopyfactory).

## Operating system support

Software package installation is only supported on RedHat based system but the configuration should work everywhere.

## Contents

The *apf* module does the following:

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
  <tr><td>**Name**</td><td>**Description**</td><td>**Default**</td></tr>
  <tr><td><code>panda_site</code></td><td>The PanDA site name</td><td><em>None</em></td></tr>
  <tr><td><code>panda_queue</code></td><td>The PanDA queue name</td><td><em>None</em></td></tr>
  <tr><td><code>panda_cloud</code></td><td>The PanDA cloud that the site belongs to</td><td><em>None</em></td></tr>
  <tr><td><code>panda_grid</code></td><td>The PanDA grid type</td><td><code>EGI</code></td></tr>
  <tr><td><code>panda_vo</code></td><td>Virtual organisation for PanDA</td><td><code>ATLAS</code></td></tr>
  <tr><td><code>factory_id</code></td><td>Unique ID string for this factory</td><td><em>None</em></td></tr>
  <tr><td><code>admin_email</code></td><td>Administrator email</td><td><em>None</em></td></tr>
  <tr><td><code>http_server_address</code></td><td>HTTP server address for logs</td><td><em>None</em></td></tr>
  <tr><td><code>use_emi_grid_software</code></td><td>Use EMI (<code>true</code>) or gLite (<code>false</code>) grid software</td><td><code>true</code></td></tr>
  <tr><td><code>debug</code></td><td>Turn on debug logging</td><td><code>undef</code></td></tr>
</table>
