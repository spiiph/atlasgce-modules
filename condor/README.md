# condor
## Description

The `condor` module manages the configuration and services for [Condor](http://research.cs.wisc.edu/htcondor/).

## Operating system support

Software package installation is only supported on RedHat based system, but the configuration should work everywhere.

## Condor roles

The `condor` module supports the following roles, all of which have their own `condor_config.local`. _Note: The `collector` and the `submit` roles have not been extensively tested._

<table>
  <tr><td>`head`</td><td>Condor manager</td><td>collector, negotiator, schedd</td></tr>
  <tr><td>`node`</td><td>Condor worker</td><td>startd</td></tr>
  <tr><td>`csnode`</td><td>Condor worker for Cloud Scheduler</td><td>startd</td></tr>
  <tr><td>`collector`</td><td>Condor manager with multiple collectors</td><td>collector\*N, negotiator, schedd</td></tr>
  <tr><td>`submit`</td><td>Condor submit node</td><td>schedd</td></tr>
</table>

## Contents

The `condor` module does the following:

* Installs the Condor package
* Creates the `condor` user and group and necessary directories
* Creates Condor job execution users (`node` and `csnode` roles)
* Creates the Condor pool password (optional)
* Writes role specific configuration to `/etc/condor/condor_config.local`
* Writes job wrapper script to `/usr/libexec/condor/jobwrapper.sh` (or `/opt/condor/libexec/jobwrapper.sh` for CernVM)
* Writes a custom service control script to `/etc/init.d/condor` (`csnode` role)
* Starts the Condor service (all roles except `csnode`)

## Variables and defaults

Here are some notable variables and their default values:

<table>
  <tr><td>`head`</td><td>The manager node</td><td>_None_</td></tr>
  <tr><td>`role`</td><td>The role of this node</td><td>_None_</td></tr>
  <tr><td>`password`</td><td>Condor pool password</td><td>`undef`</td></tr>
  <tr><td>`slots`</td><td>Condor slots per machine (&le; #CPUs)</td><td>`32`</td></tr>
  <tr><td>`collectors`</td><td>Number of collector daemons</td><td>`undef`</td></tr>
  <tr><td>`node_type`</td>`NodeType` startd attribute<td></td><td>`undef`</td></tr>
  <tr><td>`use_gsi_security`</td><td>Turn on GSI security</td><td>`false`</td></tr>
  <tr><td>`debug`</td><td>Turn on debug logging</td><td>`undef`</td></tr>
</table>
