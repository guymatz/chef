# App Specific Configuration.
default[:radioedit][:app_api] = {
  :name => "radioedit-api",
  :repo => "git@github.ihrint.com:radioedit/core.git",
  :deploy_revision => "master", # changes based on env
  :nginx_listen => 8080,
  :environment => {
    :RD_APP_NAME =>           "app_api",
    :RD_DEBUG =>              "1",
    :RD_MONGO_URI =>          "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit?replicaSet=Mongo-shared-STG",
    :RD_ELASTICSEARCH_URI =>  "http://localhost:9200/",
    :RD_CDN_URI =>            "http://api.stage.radioedit.ihr/",
    :RD_AUTH_URI =>           "http://auth.stage.radioedit.ihr/auth",
    :RD_API_URI =>            "http://api.stage.radioedit.ihr/api/rpc",
    :RD_SCRIPT_URI =>         "http://script.stage.radioedit.ihr/",
    :RD_STORAGE_URI =>        "http://api.stage.radioedit.ihr/storage",
    :RD_SERVICE_URI =>        "http://api.stage.radioedit.ihr/service",
    :RD_STORAGE_MOUNTS =>     "primary:/data/binstore",
    :RD_STATSD =>             "iad-stg-statsd101-v700.ihr",
    :RD_STATSD_PREFIX =>      "radioedit",
    #:RD_SENTRY_DSN =>         "https://c3c60ffdb0354f38ada11c9cff9be827:0bad13885cfb4024854075c58ff53295@app.getsentry.com/11937"
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




