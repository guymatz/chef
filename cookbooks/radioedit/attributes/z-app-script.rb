# App Specific Configuration.
default[:radioedit][:app_script] = {
  :name => "radioedit-script",
  :repo => "git@github.ihrint.com:radioedit/script-exec.git",
  :nginx_listen => 8080,
  :deploy_revision => "master",
  :environment => {
    :RD_APP_NAME =>           "app_script",
    :RD_DEBUG =>              "1",
    :RD_MONGO_URI =>          "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-logs?replicaSet=Mongo-shared-STG",
    :RD_CDN_URI =>            "http://api.stage.radioedit.ihr/",
    :RD_AUTH_URI =>           "http://auth.stage.radioedit.ihr/auth",
    :RD_STORAGE_URI =>        "http://api.stage.radioedit.ihr/storage",
    :RD_API_URI =>            "http://api.stage.radioedit.ihr/api/rpc",
    :RD_SERVICE_URI =>        "http://api.stage.radioedit.ihr/api/service",
    :RD_STATSD_PREFIX =>      "radioedit",
    :RD_ELASTICSEARCH_URI =>  "http://localhost:9200/",
    :RD_STATSD =>             "iad-stg-statsd101-v700.ihr",
    :RD_ACCESS_TOKEN =>       "DjT5edoi7v"
    #:RD_SENTRY_DSN =>         "https://c3c60ffdb0354f38ada11c9cff9be827:0bad13885cfb4024854075c58ff53295@app.getsentry.com/11937"
  }
}


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