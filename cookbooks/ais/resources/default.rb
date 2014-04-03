# LWRP for deploying AIS
# Provided resources/methods allowed
# Mark Rechler 2014-03-04: Initial creation

actions :deploy, :delete
default_action :deploy

attribute :path, :kind_of => String, :default => '/data/adswizz/ais'
attribute :owner, :kind_of => String, :default => 'adswizz'
attribute :group, :kind_of => String, :default => 'adswizz'
attribute :config_site, :kind_of => String, :default => 'files.ihrdev.com'
attribute :cluster_name, :kind_of => [String, NilClass], :default => nil
attribute :ais_type, :kind_of => [String, NilClass], :default => nil
attribute :version, :kind_of => [String, NilClass], :default => nil
