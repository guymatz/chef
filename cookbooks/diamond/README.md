About
=====

Diamond is a python daemon that collects system metrics and publishes them to Graphite. It is
capable of collecting cpu, memory, network, i/o, load and disk metrics.  Additionally,
it features an API for implementing custom collectors for gathering metrics from almost any source.

The documentation can be found on our [wiki](https://github.com/BrightcoveOS/Diamond/wiki). For your
convenience the wiki is setup as a submodule of this checkout. You can get it via running

    git submodule init
    git submodule update

Attributes
==========

* `default[:diamond][:version]` - Version of Diamond to install.
* `default[:diamond][:package_version]` - Package version of Diamond (i.e. Diamond 3.2 is diamond\_3.2.0\_all.deb)
* `default[:diamond][:installation_type]` - :deb, :apt or :rpm -- :deb builds a dpkg from the Brightcove git repository.
* `default['diamond']['diamond_configuration_path']` - Location of diamond.conf
* `default['diamond']['diamond_handlers']` = Default diamond handlers
* `default['diamond']['diamond_user']` - User to run diamond as
* `default['diamond']['diamond_group']` - Group to run diamond as
* `default['diamond']['collectors_config_path']` - Location of collector configurations
* `default['diamond']['collectors_reload_interval']` - How often to check for new collector configs in seconds
* `default['diamond']['archive_handler']` - Settings for archive handler
* `default['diamond']['graphite_handler']` - Settings for graphite handler
* `default['diamond']['graphite_picklehandler']` - Settings for graphite pickle handler
* `default['diamond']['statsdhandler']` - Settings for statsd handler
* `default['diamond']['tsdbhandler']` - Settings for tsdb handler
* `default['diamond']['mysqlhandler']` - Settings for mysql handler
* `default['diamond']['force_install']` - Set to true to force a rebuild and install of diamond

* `default['diamond']['add_collectors'] - List of collectors to enable.  Defaults to diamond default collector list.

Definitions
===========
This cookbook has a definition to make it easy to create collector configs. By default, the definition enables the
collector. You can supply it with addition parameters. Below is the simplest example.

```
    collector_config "CPUCollector"
```

This simple example just enables the collector and it inhereits the default configuration for this collector as defined
by the collector.

You can override these default settings by passing additional parameters. Below is an example of this.

```
    collector_config "DiskSpaceCollector" do
      filesystems      'ext2,ext3,xfs'
      exclude_filters  "'^/export/home'"
    end
```

This example is enabling the DiskSpaceCollector while passing addition settings to specify which filesystems to mine data 
and to exclude certain directories (regex). Read the documentation/collector source code for information on what parameters
each collector has.
It is recommended that instead of passing values directly, inherit them from the node (as show belown).

```
    collector_config "DiskSpaceCollector" do
      filesystems      node[:diamond][:collectors][:DiskSpaceCollector][:filesystems]
      exclude_filters  node[:diamond][:collectors][:DiskSpaceCollector][:exclude_filters]
    end
```

When you are collecting data via snmp, you need to specify that in the definition (as shown below)
```
      collector_config "SNMPInterfaceCollector" do
        path      node[:diamond][:collectors][:SNMPInterfaceCollector][:path]
        snmp      true
        interval  node[:diamond][:collectors][:SNMPInterfaceCollector][:interval]
        timeout   node[:diamond][:collectors][:SNMPInterfaceCollector][:timeout]
        retries   node[:diamond][:collectors][:SNMPInterfaceCollector][:retries]
        port      node[:diamond][:collectors][:SNMPInterfaceCollector][:port]
        community node[:diamond][:collectors][:SNMPInterfaceCollector][:community]
        devices   node[:diamond][:collectors][:SNMPInterfaceCollector][:devices]
      end
```
Whats with the double underscore ('__')?
if a double underscore exists in the attribute name, it will be automatically removed when written to the collector config file.
This is due to limitations within ruby code. Sometimes a attibute name may be a reserved ruby word (ie timeout), in which
case, you can't use that key to specify an attribute for the collector. The use of double underscores ('__') is a work around for that. 
(so 'timeout' is called as 'time__out' in the cookbook, but writes 'timeout' to the config file.

Usage
=====
It is recommended that you create a recipe per collector, and add that recipe to the related role.
When passing sensitive data to a diamond collector config (ie a username, password, etc), use data bags 
to encrypt the values.

