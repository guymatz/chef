#
# Author:	Jake Plimack <jake.plimack@gmail.com
# Cookbook Name::memcached
# Resource::memcached_instance
#

actions :create, :remove

def initialiaze(*args)
    super
    @action = [:enable, :start]
end

attribute :name, :kind_of => String, :name_attribute => true
attribute :listen, :kind_of => String, :default => "0.0.0.0"
attribute :memory, :kind_of => Integer, :default => nil
attribute :port, :kind_of => Integer, :default => "11211"
attribute :options, :kind_of => String, :default => ''
