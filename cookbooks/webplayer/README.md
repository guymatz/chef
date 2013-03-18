webplayer Cookbook
==================
TODO: Enter the cookbook description here.

e.g.
This cookbook configures and deploys WebPlayers

Requirements
------------
* Nagios
* Application_python (Django)
* Nginx (handles connections for Django)
* Linux, Any

e.g.
#### packages
* Virtualenv

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### webplayer::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['webplayer']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### webplayer::default
Just include `webplayer` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[webplayer]"
  ]
}
```
Though... making a webplayer role with other cookbooks grouped together makes sense, too.

Contributing
------------
* Talk to Jake Plimack

e.g.
1. Fork the repository on Github (git clone git@github.com:iheartradio/iheart-chef)
2. Create a named feature branch (like `add_component_x`) (git branch awesome-feature; git checkout !$)
3. Write you change (git add ....; git commit -m ".....")
4. Write tests for your change (if applicable) (Bonus Points)
5. Run the tests, ensuring they all pass (Throw it on jenkins)
6. Submit a Pull Request using Github (We'll love you for it)

License and Authors
-------------------
Authors: Jake Plimack <jake.plimack@gmail.com>
