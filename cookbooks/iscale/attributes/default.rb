# ##########################################################
#
# Cookbook Name:: iscale
# Author:: Gregory Patmore <gregory.patmore@clearchannel.com> 
# 
# Copyright:: 2013, iHeartRadio
# All rights reserved - Do Not Redistribute
# JIRA-REF:: http://jira.ccrd.clearchannel.com/browse/OPS-6017
# ##########################################################

# Branch settings based on environment [/^prod/ , /^stage/ , or <anything else> ]
case chef_environment

# Production environment settings
when /^prod/

  default.iscale = {
    # owner of the application files/processes/recources
    :user              => 'root',
    # group of the application files/processes/recources
    :group             => 'root',
    # path to the application install directory (chef's revision control happens within this directory)
    :install_path      => '/data/apps/iscale',
    # path to the currently deployed version of the application
    :app_homedir       => '/data/apps/iscale/current',
    # subsystem lock file used by sysv init system to ensure singleton process administration
    :lock_file         => '/var/lock/subsys/iscale',
    # pid file used by sysv init
    :pid_file          => '/var/run/iscale',
    # git repository used to pull revisions of the codebase
    :git_repository    => 'git@github.com:iheartradio/iscale.git',
    # git repository branch or tag used to indicate which revision to pull
    :git_branch        => 'master',
    # path to the settings json file used to load the correct app settings per env
    :settings_path     => '/data/apps/iscale/settings.json',

    # Application settings propegated to the file indicated in the :settings_file attibute
    :app_settings      => {
      # application environment name
      :env                      => '"production"',
      # application listening port
      :port                     => '3000',
      # URL for use in making amp api requests
      :ampURL                   => '"http://iad-amp-vip-v200.ihr/api/"',
      # host to connect to for sending graphite data
      :statsdHost               => '"iad-statsd101.ihr"',
      # port to connect to for sending graphite data
      :statsdPort               => '8125',
      # path to the application log file
      :logPath                  => '"/var/log/iscale/iscale.log"',
      # port to connect to for making varnish management requests
      :varnishManagementPort    => '6082'
    }

  };

# Staging environment settings
when /^stage/

  default.iscale = {
    # owner of the application files/processes/recources
    :user              => 'root',
    # group of the application files/processes/recources
    :group             => 'root',
    # path to the application install directory (chef's revision control happens within this directory)
    :install_path      => '/data/apps/iscale',
    # path to the currently deployed version of the application
    :app_homedir       => '/data/apps/iscale/current',
    # subsystem lock file used by sysv init system to ensure singleton process administration
    :lock_file         => '/var/lock/subsys/iscale',
    # pid file used by sysv init
    :pid_file          => '/var/run/iscale',
    # git repository used to pull revisions of the codebase
    :git_repository    => 'git@github.com:iheartradio/iscale.git',
    # git repository branch or tag used to indicate which revision to pull
    :git_branch        => 'master',
    # path to the settings json file used to load the correct app settings per env
    :settings_path     => '/data/apps/iscale/settings.json',

    # Application settings propegated to the file indicated in the :settings_file attibute
    :app_settings      => {
      # application environment name
      :env                      => '"dev"',
      # application listening port
      :port                     => '3000',
      # URL for use in making amp api requests
      :ampURL                   => '"https://api2.iheart.com/api/"',
      # host to connect to for sending graphite data
      :statsdHost               => '"iad-statsd101.ihr"',
      # port to connect to for sending graphite data
      :statsdPort               => '8125',
      # path to the application log file
      :logPath                  => '"/var/log/iscale/iscale.log"',
      # port to connect to for making varnish management requests
      :varnishManagementPort    => '"6082"'
    }

  };

# if no known env then set up as dev to make sure we don't impact stage/prod
else 

  default.iscale = {
    # owner of the application files/processes/recources
    :user              => 'root',
    # group of the application files/processes/recources
    :group             => 'root',
    # path to the application install directory (chef's revision control happens within this directory)
    :install_path      => '/data/apps/iscale',
    # path to the currently deployed version of the application
    :app_homedir       => '/data/apps/iscale/current',
    # subsystem lock file used by sysv init system to ensure singleton process administration
    :lock_file         => '/var/lock/subsys/iscale',
    # pid file used by sysv init
    :pid_file          => '/var/run/iscale',
    # git repository used to pull revisions of the codebase
    :git_repository    => 'git@github.com:iheartradio/iscale.git',
    # git repository branch or tag used to indicate which revision to pull
    :git_branch        => 'master',
    # path to the settings json file used to load the correct app settings per env
    :settings_path     => '/data/apps/iscale/settings.json',

    # Application settings propegated to the file indicated in the :settings_file attibute
    :app_settings      => {
      # application environment name
      :env                      => '"dev"',
      # application listening port
      :port                     => '3000',
      # URL for use in making amp api requests
      :ampURL                   => '"https://api2.iheart.com/api/"',
      # host to connect to for sending graphite data
      :statsdHost               => '"iad-statsd101.ihr"',
      # port to connect to for sending graphite data
      :statsdPort               => '8125',
      # path to the application log file
      :logPath                  => '"/var/log/iscale/iscale.log"',
      # port to connect to for making varnish management requests
      :varnishManagementPort    => '6082'
    }

  };

end
