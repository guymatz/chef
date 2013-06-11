elasticsearch Cookbook
======================
Installs elasticsearch with plugins, sets ulimits, enables the service.

Continuous Integration
======================
Elasticsearch is build by Jenkins (Here)[http://build.ihrdev.com/job/ElasticSearch/]

#### process
Jenkins builds are kicked off manually by a developer and source from (the github repo)[https://github.com/iheartradio/iheart-chef/tree/master/cookbooks/elasticsearch].  Upon a succesful build,
the build artifacts are tarballed and then SCP'd to (files.ihrdev.com/elasticsearch)[http://files.ihrdev.com/elasticsearch]

When chef-client runs, it will download the tarball and expand it to the appropriate location.  In order for chef to replace files that already exist, the `checksum` of the tarball must be updated.

If any files are updated by the chef-client, it will restart the `elasticsearch` process, as well/

Requirements
------------
#### packages
- `nagios` - for NRPE checks
- `users` - to grant access

Attributes
----------
- `ulmits` - sets process and file handle limits
- `shards` - search database shard count
- `replicas` - search database replica count
- `mlockadd` - true/false

Usage
-----
Just include `role[elasticsearch]` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "role[elasticsearch]"
  ]
}
```

License and Authors
-------------------
Authors: Jake Plimack <jake.plimack@gmail.com>
         Amit Patel <amitpatel@clearchannel.com>
