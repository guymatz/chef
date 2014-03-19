ais Cookbook
============
This cookbook deploys the AIS package on a master or edge.

Requirements
------------
#### cookbooks
- `sysctl` - Used to tune the system for concurrency.

#### packages
- `ais` - The software rpm to be in an accessible repo.
- `java-1.7.0-openjdk` - AIS needs Java for log shipping.

Attributes
----------
#### ais::default

`['ais']['sysctl_settings']` - Hash - sysctl server tuning keys and values.

#### role/node
There are a few attributes that will be unique per cluster/ais setup so these are probably best set on the role or node level.

`['ais']['install_id']` - String - AIS Installation ID/License number, needed to start the service and tie to a corresponding remote config.

`['ais']['cluster_name']` - String - Cluster identifier, a logical name to seperate configs.

`['ais']['ais_type']` - String - Deploy a master or edge.

`['ais']['version']` - String - Specifies the version of the package to deploy.

Tags
----
`ais-deployed` - Indicates that the application has been deployed. Must be removed to update the config or the software.

`reload-only` - Indicates whether or not to restart the service. Most config changes can occur via a SIGHUP and do not require a restart. Remove if a restart is desired.

Usage
-----
#### ais::deploy

Include `recipe[ais::deploy]` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ais::deploy]"
  ]
}
```

#### ais provider attribute parameters
- `actions` - deploy (default action)/delete - deploy or remove the application.
- `path` - system path that specifies where the RPM is deployed - default: `/data/adswizz/ais`.
- `owner` - username of the application owner - default: `adswizz`.
- `group` - group name of the application group - default: `adswizz`.
- `config_site` - HTTP hostname where the application configs live - default: `files.ihrdev.com`.
- `cluster_name` - Cluster identifier to determine which configs to pull - default: `nil`.
- `ais_type` - Master or edge node - default: `nil`.
- `version` - AIS RPM version to deploy - default: `nil`.

example:
```
ais "server" do
  action :deploy
  cluster_name node[:ais][:cluster_name]
  ais_type node[:ais][:ais_type]
  config_site '10.5.57.10:8080/cobbler/pub'
  version node[:ais][:version]
end
```

License and Authors
-------------------
Authors: Mark Rechler
