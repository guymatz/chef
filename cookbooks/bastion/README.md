bastion Cookbook
================
Configures a secured SSH Bastion Server

A bastion host is a special purpose computer on a network specifically designed and configured to withstand attacks. The computer generally hosts a single application, for example a proxy server, and all other services are removed or limited to reduce the threat to the computer. It is hardened in this manner primarily due to its location and purpose, which is either on the outside of the firewall or in the DMZ and usually involves access from untrusted networks or computers.

Requirements
------------
#### packages / cookbooks
- `users` - bastion needs a set of users allowed to proxy.
- `sudo` - admins need to be able to root up
- `monitored` - deploy out suite of monitoring tools
- `openssh` - setup SSH and IPtables rules
- `iptables` - permit what you want, deny everything else
- `ntp` - sync time
- `chef-client` - self explanitory
- `operations` - our toolbelt
- `timezone` - tool it out
- `zsh` - some of us are special

Usage
-----
Just include `role[bastion]` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "role[bastion]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Jake Plimack <jake.plimack@gmail.com>
