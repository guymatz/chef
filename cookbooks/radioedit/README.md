radioedit Cookbook
==================
Cookbook to handle the deployment of the radioedit stack.   THis has been refactored after the Ganon release
to handle the new architecture of HAN.  This release starts the splitting up of the service into multiple services 
(which can either run on the same host, or seperate hosts). 

It is a refactor to allow for the provisioning of these apps through LWRP.   


Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

#### packages
    python
    application_python
    sudo
    nodejs (only for radioedit app-script application currently) 
    logrotate
    sudo


Attributes
----------
There are placeholder attrivbutes setup for each block as well as some global defs:

Default directory structure
    default[:radioedit][:req_dirs] = %w{
        /data
        /data/apps
        /data/apps/radioedit
        /data/legacy
        /data/legacy/p4
        /var/run/radioedit
        /var/log/radioedit
    };


These are shared amongst all services / apps deployed

    default[:radioedit][:path] = "#{default[:radioedit][:app_root]}/radioedit"
    default[:radioedit][:app_user] = "ihr-deployer"
    default[:radioedit][:log_dir] = "/var/log/radioedit"
    default[:radioedit][:utildir] = "#{default[:radioedit][:path]}/util"
    default[:radioedit][:asset_dir] = "/data/binstore/assets"

The setup of the attributes switches on which enviornment you are currently tagged on.   It tries to simply the defaults by pre-populating things that are/should be the same for all envs.  They can/are overridden in the actual enviornments as needed, example:

# App Specific Configuration.
    default[:radioedit][:app_api] = {
      :name => "radioedit-api",
      :repo => "git@github.ihrint.com:radioedit/core.git",
      :deploy_revision => "", # changes based on env
      :environment => {
        :app_name =>            "radioedit-api",
        :debug =>               "", # changes based on env
        :mongo_uri =>           "", # changes based on env
        :elasticsearch_uri =>   "", # changes based on env
        :cdn_uri =>             "", # changes based on env
        :auth_uri =>            "", # changes based on env
        :storage_mounts =>      "primary:/data/binstore",
        :statsd =>              "", # changes based on env
        :statsd_prefix =>       "radioedit",
        :sentry_dsn =>          ""  # changes based on env
      },
    }

And then the ovverride in the actual env:
    case chef_environment

        when /^stage-jd/
        # ################################################################
        # Stage Environment settings.
        # ################################################################

            override[:memcached][:memory]  = 64;

            #
            # app specific settings, overrides for STAGE env
            # APP_API
            #
            default[:radioedit][:app_api][:deploy_revision] = "ganon.3"
            default[:radioedit][:app_api][:environment][:mongo_uri] = "..."
            default[:radioedit][:app_api][:branch] = "staging"
            default[:radioedit][:app_api][:env] = "ihr_testing"
            default[:radioedit][:app_api][:statsd] = "iad-stg-stasd101-v700.ihr"
            default[:radioedit][:app_api][:statsd_prefix] = "radioedit"
            default[:radioedit][:app_api][:elasticsearch_uri] = "127.0.0.1:9200"
            default[:radioedit][:app_api][:auth_url] = "127.0.0.1:80"
            default[:radioedit][:app_api][:sentry_dsn] = "null"
            default[:radioedit][:app_api][:cdn_url] = "http://10.5.1.28/"
            default[:radioedit][:app_api][:port] = "8080"
            default[:radioedit][:app_api][:elastic_clustername] = "radioedit-staging";
            default[:radioedit][:app_api][:staticdir] = "#{default[:radioedit][:path]}/app-api/static"


Usage
-----
#### radioedit::default
TODO: Write usage instructions for each cookbook.

User creation:  For devs or anyone that needs access to the radioedit class machines, add:

    'radioedit'

to their groups list in their databag.  This by default also gives sudo privs to anyone currently without password.

By default each "radioedit" app server should include the follwing in their runlist:


    "recipe[users::deployer]"  # sets up the generic deployer account

    "recipe[radioedit]", # default recipe, sets up all the actual user accounts, not much else

    "recipe[radioedit::radioedit]",  # this is a big one, it sets up directory structure and all the packages

    "recipe[radioedit::radioedit-script]", # installs the nodejs script service

    "recipe[radioedit::radioedit-auth]", # installs the auth service

    "recipe[radioedit::radioedit-api]" # installs the api (core) service

The bulk of the work is done in the LWRPs

    node.rb -> Is the LWRP for setting up a node.js 
    unicorn.rb -> Is the LWRP for setting up a unicorn app

The providers don't take any arguments and basically decide the path and application name based on how you are calling it:

    radioedit_unicorn "app-api" do
        action :init
        not_if { node.tags.include?(radioedit.app-api) }
    end

It then sets the app_name

    app_name = "#{new_resource.name}"

And everything is keyed off that, trying to make the provider as agnostic as possible.  

License and Authors
-------------------
Authors: 
Greg Patmore
John Deragon
Mark Rechler
