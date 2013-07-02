Flume-NG Cookbook
=================
Deploys flume-ng on CentOS servers

Supports
--------
* `CentOS >= 6.3`

Requirements
------------
#### Packages
- `java >= 1.6`

Usage
-----
Just include `role[flume-ng]` in your node's `run_list`:

```json
{
    "name":"my_node",
    "run_list": [
        "role[flume-ng]"
     ]
}
```

Deployment
==========
Tags
----
- `flume-deployed` - when this tag is set, chef-client will not attempt to redeploy flume.  The tag essentially locks down the config until an operator manually clears it.
* To clear a single tag: `knife tag delete iad-amp101.ihr "flume-deployed"`
* To clear tags for a set of servers: `knife tag buld delete "role:flume-ng" "flume-deployed"`

CI
--
Flume-NG is build by Jenkins [http://build.ihrdev.com/job/flume/].  Upon a successful build, dist tarballs are shipped to [http://files.ihrdev.com/flume].

License and Authors
-------------------
Authors: Pavel Katsev <pkatsev@clearchannel.com>
         Mark Rechler <MarkRechler@clearchannel.com>
