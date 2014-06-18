# circus

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with circus](#setup)
    * [What circus affects](#what-circus-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with circus](#beginning-with-circus)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

[Circus][circus] is a process and socket manager by [Mozilla][moz]. Its goal
is similar to other tools like Supervisord, runit, god etc. It is built on a
much more modern and scalable foundation powered by [ZeroMQ][zmq].

## Module Description

This module will install Circus for you. This entails installing the necessary
packages, creating the configuration directories and writing the main
circusd.ini to get you started.

Because there currently aren't any packages to install Circus from we rely on
`pip` to do the heavy lifting for us.

We also ship with Upstart, systemd and Sys-V startup scripts which are taken
directly from Mozilla's [source code repository][circus]. Any issues with the
startup scripts should be raised with [Mozilla][circus].

## Setup

### What circus affects

* Install circus from PyPi;
* Create `/etc/circus`, `/etc/circus/conf.d`;
* Create `/etc/circus/circusd.ini`
* Symlink `/usr/local/bin/circusctl` and `/usr/local/bin/circusd` into
  `/usr/bin`.

### Setup requirements

Python and Pip must be available for this module to be able to work.

### Beginning with circus

To install circus:

```puppet
include ::circus
```

## Usage

Because Circus is still relatively new and packages are bound to pop up at
some point in time you might want to switch to those instead. To make this
possible a few variables have been defined:

* `package_circus`: defaults to `circus`;
* `package_circus_provider`: defaults to `pip`, set to `undef` to let Puppet
  figure out which one to use on your platform;
* `package_circus_dependencies`: List of dependent packages not available from
  PyPi;

## Reference

### Classes

#### Class `circus`

* `package_ensure`: in what state we want Circus
    * default: `installed`
    * option: valid values for the package type's ensure attributed except for
              `held` and `purged`
    * type: string
* `package_circus`: name of the Circus package
    * default: `circus`
    * option: whatever works for you
    * type: string
* `package_circus_provider`: what provider to use to install Circus
    * default: `pip`
    * option: any valid provider for the package type, use `undef` to use your
              platforms default
    * type: string
* `package_circus_dependencies`: additional dependencies to install
    * default: `[]`
    * option: an array of package names
    * type: array of strings
* `service_circus_provider`: init-system to configure
    * default: `sysv`
    * option: `sysv`, `upstart, `systemd`
    * type: string
* `conf_prefix`: where to create the Circus configuration directory
    * default: `/etc`
    * option any absolute path
    * type: string that validates as an absolute path
* `log_prefix`: where to create the Circus logging directory
    * default: `/var/log`
    * option: any aboslute path
    * type: string that validates as an absolute path
* `logrotate_dir`: where to install the logrotate configuration
    * default: `/etc/logrotate.d`
    * option: any aboslute path
    * type: string that validates as an absolute path

#### Private Classes

Though you can call these classes individually they are considered private and
depend on variables set in the main `circus` class.

* `circus::install`: installs Circus;
* `circus::configure`: writes configuration files for Circus;
* `circus::services`: starts and manages the Circus daemon.

## Limitations

This module requires Puppet 3. We test on the full set of supported Rubies but
only the latest Puppet version. Since this module does not rely on any fact we
do not explicitly test against mutliple Facter versions.

It should work on most Linux platforms. BSD's are currently missing rc-scripts
and probably a few other things but support should be trivial to add.

Windows is not supported.

## Development

This module is hosted on [Github][gh], that is where all development takes
place. Feel free to fork the module and send pull requests for the
enhancements you want to merge.

When you change something or add something new you are expected to:
* provide a rationale for the change ('because it suits me better is not a
  good reason');
* modify or add tests for the new behaviour.

[circus]: https://github.com/mozilla-services/circus.git
[moz]: https://blog.mozilla.org/services/
[zmq]: http://zeromq.org/
[gh]: https://github.com/daenney/puppet-circus
