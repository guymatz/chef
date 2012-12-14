Description
===========
Cookbook version of the Chef Exception & Reporting Handler for Splunk.

[![Build Status](https://secure.travis-ci.org/ampledata/cookbook-splunk_handler.png?branch=master)](http://travis-ci.org/ampledata/cookbook-splunk_handler)


Requirements
============
The `chef_handler` cookbook.


Attributes
==========
This cookbook uses the following attributes to configure how it is installed.

Required Attributes
-------------------
* `node['chef_client']['handler']['splunk']['username']` - Username
  for Splunk Server.
* `node['chef_client']['handler']['splunk']['username']` - Password for Splunk Server.
* `node['chef_client']['handler']['splunk']['host']` - Splunk Server Host Name.

Optional Attributes
-------------------
* `node['chef_client']['handler']['splunk']['port']` - Splunk Server Management Port (Default '8089').
* `node['chef_client']['handler']['splunk']['index']` - Index to use on
  the Splunk Server (Default 'main').
* `node['chef_client']['handler']['splunk']['scheme']` - Protocol Scheme
  to use when connecting to the Splunk Server (Default 'https').


Usage
=====
1. Set at least the `username`, `password` and `host` Attributes on a
  Node.
2. Add the `splunk_handler` Cookbook to a Node's Run List.


Source
======
https://github.com/ampledata/cookbook-splunk_handler

Author
======
Author:: Greg Albrecht (mailto:gba@splunk.com) for splunk_handler.
Author:: Peter Donald for graphite_handler.

Credits
=======
The splunk_handler Cookbook is based on the graphite_handler Cookbook
written by Peter Donald.

Copyright
=========
Copyright 2012 Splunk, Inc.

License
=======
Apache License 2.0. See LICENSE.txt
