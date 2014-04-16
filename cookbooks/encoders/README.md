encoder Cookbook
=================
TODO: Massive cookbook to deploy our encoder / transcoder / ingestion enviornment


1.0.2 added dir_links recipe

Requirements
------------

#### packages needs: 
YUM
Java
Line
Application_Ruby
Tomcat7

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### encoder::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['encoders']['checkout']</tt></td>
    <td>Boolean</td>
    <td>Controls checkout of ruby repo from github "converter" repo </td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['encoders']['default']</tt></td>
    <td>Boolean</td>
    <td>Default</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['encoders']['ftpserver']</tt></td>
    <td>Boolean</td>
    <td>Builds the vsftp ftpserver</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['encoders']['ingestion']</tt></td>
    <td>Boolean</td>
    <td>Deploys packages and symlinks related to ingestion manager machines</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['encoders']['talk']</tt></td>
    <td>Boolean</td>
    <td>Deploys packages and symlinks related to machines handling talk</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['encoders']['vantrix']</tt></td>
    <td>Boolean</td>
    <td>Deploys packages and symlinks related to machines handling vantrix</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['encoders']['mixins']</tt></td>
    <td>Boolean</td>
    <td>Deploys packages and symlinks related to machines handling mixins</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
</table>

checkout.rb  default.rb  ftpserver.rb  ingestion.rb  links.rb  manager.rb  mixins.rb  talk.rb  vantrix.rb
Usage
-----
#### encoder::default
TODO: Write usage instructions for each cookbook.



License and Authors
-------------------
Authors: John Deragon - jderagon@clearchannel.com
