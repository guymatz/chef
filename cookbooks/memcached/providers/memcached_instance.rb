#
# Cookbook Name::memcached
# Provider::memcached_instance
#

action :create do
  t = template "/etc/sysconfig/memcached_#{new_resource.port}" do
    cookbook new_resource.cookbook
    source "memcached.sysconfig.erb"
    mode "0644"
    owner node[:memcached][:user]
    options = Array.new
    options.push('-vv >> /var/log/memcached 2>&1')
    options = options|new_resource.options
    variables({
        :listen => new_resource.name,
	:user => node[:memcached][:user],
	:port => new_resource.port,
	:maxconn => new_resource.maxconn,
	:memory => new_resource.memory,
	:options => options
	})
    action :create
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :remove do
  if ::File.exists?("/etc/sysconfig/memcached_#{new_resource.port}")
    Chef::Log.info("Removing memcached_#{new_recource.port} from /etc/sysconfig")
    file "/etc/sysconfig/memcached_#{new_resource.port}" do
      action :delete
      notifies :restart, "service[memcached]"
    end
    new_resource.updated_by_last_action(true)
  end
end

