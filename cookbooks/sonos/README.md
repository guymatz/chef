Sonos Cookbook
==============
deployed sonos from git repo.  sonos is a django application which provides a SOAP interface for sonos clients.  Sonos used mysql for "cacheing".  For this purpose, there is an HA-mysql pair running in EC2 named use1b-ss-db101 (VIP).  Further instructions on setting up sonos can be found in the sonos repo [https://github.com/iheartradio/sonos].

Requirements
------------
#### packages / cookbooks / roles
- `application_python` - creates a standard python/virtualenv/supervisord (django) application stack from a github repo containing a requirements.txt
- `mysql` - client interface to mysql databases
- `nagios` - NRPE checks
- `users` - configures users

Usage
-----
Just include `role[sonos]` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "rolee[sonos]"
  ]
}
```

License and Authors
-------------------
Authors: Jake Plimack <Jake.plimack@gmail.com>
