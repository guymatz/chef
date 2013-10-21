Bondage Cookbook
================
Creates bonded interfaced with 802.1q VLAN tags from DNS or static configs.
Before running the recipe, you should configure the DNS entries and update dns.
You can test it like this, if you were trying to set up `jobservers`.
```bash
# dig AXFR ihr @10.5.32.21 | grep jobserver
iad-jobserver101.ihr.        21600      IN      A      10.5.33.10
iad-jobserver101-v200.ihr.   21600      IN      A      10.5.41.10
iad-jobserver101a.ihr.       21600      IN      A      10.5.33.11
iad-jobserver101a-v200.ihr.  21600      IN      A      10.5.41.11
iad-jobserver101b.ihr.       21600      IN      A      10.5.33.12
iad-jobserver101b-v200.ihr.  21600      IN      A      10.5.41.12
```

Requirements
------------
`modules`
`heartbeat` (optional)

Usage
-----
#### bondage::default
The default recipe only sets up modprobe bonding
#### bondage::dns
Looks up sub-interfaces in DNS and configures the interfaces accordingly
If the node has heartbeat in it's runlist, `bondage::dns` will add attributes for heartbeat in
`node[:heartbeat][:haresources][:intf_vlan]`.

#### bondage::static
does absolutely nothing

Example
-----
Just include `bondage::dns` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bondage::dns]"
  ]
}
```
