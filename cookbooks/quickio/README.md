Quick.IO Cookbook
================
Deploys quickio on Debian servers

Supports
--------
* `Debian >= 7.0`

Requirements
------------
#### Packages
- `python >= 2.7.0`

Usage
-----
Just include `role[quickio]` in your node's `run_list`:

```json
{
    "name":"my_node",
    "run_list": [
        "role[quickio]"
     ]
}
```

Deployment
==========
Tags
----
- `quickio-deployed` - when this tag is set, chef-client will not attempt to redeploy amp.  The tag essentially locks down the config until an operator manually clears it.
* To clear a single tag: `knife tag delete iad-amp101.ihr "quickio-deployed"`
* To clear tags for a set of servers: `knife tag buld delete "role:quickio" "quickio-deployed"`

CI
--
Quick.IO is build by Jenkins [http://build.ihrdev.com/view/Quick.IO/].  Upon a successful build, files are packaged as debs and shipped to [http://files.ihrdev.com/Quick.IO/].  In order to update the environment, the version set in the attribute file must be updated, as well as the tags cleared.
