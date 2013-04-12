fac Cookbook
============
Deploys FAC, USR-FAC, FAC-prn, FAC-music, FAC-talk


Requirements
------------
#### FAC-{jobs}
A jobserver to run tasks on
#### FAC, USR-FAC
A Mongo cluster
`mongo`

#### packages
- `mongo` - a NOSQL database that works in mysterious and unpredictable ways

Usage
-----
#### fac::default
Does more than you... i.e. nothing
#### fac::prn
Sets up the fac-prn jobs
#### fac::talk
Sets up the fac-talk jobs
#### fac::music
Sets up the fac-music jobs
#### fac::fac
Deploys and configures the mongo 'fac' cluster
#### fac::usrfac
Deploys and configures the mongo 'usr-fac' cluster

e.g.
Just include `fac::recipe` in your node's `run_list`:

```json
{
  "name":"iad-jobserver101",
  "run_list": [
    "recipe[fac::prn]"
  ]
}
```

License and Authors
-------------------
Authors: Jake Plimack <jake.plimack@gmail.com>
