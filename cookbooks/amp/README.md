amp Cookbook
============


Requirements
------------
#### os
`centos`, `debian`

#### packages / cookbooks / roles
- `users` - configure users who can access amp
- `tomcat7` - run java apps
- `java` - java
- `mongodb` - provides access to mongodb
- `nagios` - configures NRPE checks
- `cron` - scheduled tasks

Attributes
----------
<table>
  <tr>
    <th>version</th>
  </tr>
  <tr>
    <td><tt>version of amp to grab from files.ihrdev.com</tt></td>
  </tr>
</table>

Tags
----
- `amp-deployed` - when this tag is set, chef-client will not attempt to redeploy amp.  The tag essentially locks down the config until an operator manually clears it.
* To clear a single tag: `knife tag delete iad-amp101.ihr "amp-deployed"`
* To clear tags for a set of servers: `knife tag buld delete "role:amp" "amp-deployed"`


Continuous Integration
======================
Jenkins builds Amp as part of the (Amp-Release)[http://build.ihrdev.com/view/Amp/job/Amp-Release/] job.  Upon successful build, the artifacts are renamed (versioned) and SCP'd to (files.ihrdev.com/amp/&lt;version&gt;/)[http://files.ihrdev.com/amp/].  In order to update the environment, the version set in the attribute file must be updated, as well as the tags cleared.

Usage
-----
Just include `role[amp]` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "rolee[amp]"
  ]
}
```

License and Authors
-------------------
Authors: Jake Plimack <jake.plimack@gmail.com>
