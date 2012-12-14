Description
===========
Cookbook for installing splunkforwarder.

[![Build Status](https://secure.travis-ci.org/ampledata/cookbook-splunkforwarder.png?branch=master)](http://travis-ci.org/ampledata/cookbook-splunkforwarder)


Requirements
============
* Linux host on which to run splunkforwarder.


Attributes
==========
This Cookbook uses the following Attributes to configure the
splunkforwarder installation.

Required Attributes
-------------------
The following Required Attributes have default settings, see
`attributes/default.rb`:

* `node['splunkforwarder']['download_url']` - URL to the splunkforwarder
  download site.
* `node['splunkforwarder']['build']` - Build Number (CL#) of
  splunkforwarder package to install.

* `node['splunkforwarder']['version']` - Version of splunkforwarder
  package to install.


Usage
=====
1. Add this Cookbook to a Node's Run List.


Source
======
https://github.com/ampledata/cookbook-splunkforwarder

Author
======
Author:: Greg Albrecht (mailto:gba@splunk.com) for splunkforwarder.
Author:: Aaron Wallis (aaron.wallis@lexer.com.au) for stormforwarder.

Credits
=======
The splunkforwarder Cookbook is based on the stormforwarder Cookbook
written by Aaron Wallis of Lexer.

Copyright
=========
Copyright 2012-2013, Lexer Pty Ltd.
Copyright 2012 Splunk, Inc.

License
=======
Apache License 2.0. See LICENSE.txt
