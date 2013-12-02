template "/etc/init.d/subscription" do
  source "java.init.erb"
end

bash "install-subscription-service" do
  code "chkconfig --add subscription"
  not_if "chkconfig --list | egrep '^subscription'"
end

service "subscription" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :enable, :start ]
end

remote_file "#{node[:subscription][:path]}/subscription.jar" do
  source "http://files.ihrdev.com/subscription-service/stage/subscriptions-service.jar/subscriptions-service-1.0.3.jar"
end

template "#{node[:subscription][:path]}/config.yml" do
  notifies :restart, "service[subscription]", :immediately
end
