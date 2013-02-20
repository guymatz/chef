default[:gem_server][:rf_virtual_host_name]  = "rubygems.#{domain}"
default[:gem_server][:rf_virtual_host_alias] = [ "gems.ihrdev.com", 
                                                 "xgems.ihrdev.com" ]
default[:gem_server][:rf_directory]          = "/data/gems.repo"

default[:gem_server][:ruby_gems]             = "http://rubygems.org"
