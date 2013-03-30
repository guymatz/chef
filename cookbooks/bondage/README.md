bondage Cookbook
================
Creates bonded interfaced with 802.1q VLAN tags from DNS or static configs.

Requirements
------------

#### packages

Attributes
----------
#### bondage::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bondage']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### bondage::default
The default method is DNS
#### bondage::dns
#### bondage::static

Just include `bondage` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bondage]"
  ]
}
```
License and Authors
-------------------
Authors: Jake Plimack <jake.plimack@gmail.com> http://jakeplimack.com


