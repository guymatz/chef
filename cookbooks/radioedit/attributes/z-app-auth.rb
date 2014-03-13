# App Specific Configuration.
default[:radioedit][:app_auth] = {
  :name => "radioedit-auth",
  :repo => "git@github.ihrint.com:radioedit/auth.git",
  :deploy_revision => "master", # changes based on env
  :nginx_listen => 8080,
  :environment => {
    :RD_APP_NAME =>           "app_auth",
    :RD_DEBUG =>              "1",
    :RD_MONGO_URI =>          "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-auth?replicaSet=Mongo-shared-STG",
    :RD_STATSD =>             "iad-stg-statsd101-v700.ihr",
    :RD_STATSD_PREFIX =>      "radioedit",
    #:RD_SENTRY_DSN =>         "https://5a99baf425954927b38c9c7373502abf:e86faffebc4e4a9f854e0fedfd2a585a@app.getsentry.com/18592"
  }
};

# ################################################################
# Environment specific settings start here
# ################################################################
case chef_environment

  # ################################################################
  # PRODUCTION SETTINGS!!!!!
  # ################################################################
  when /^prod/


  # END PRODUCTION SETTINGS

  # ################################################################
  # Stage Environment settings.
  # ################################################################
  when /^stage/


  # END STAGE SETTINGS

  # ################################################################
  # Development Environment settings.
  # ################################################################
  when /^dev/
    
  # END DEVELOPMENT SETTINGS
  # ################################################################
  # Invalid environment
  # ################################################################
  else


  # end Invalid environment

end  # end case chef_environment