# Load sensitive info from encrypted data bag
vindicia_creds = Chef::EncryptedDataBagItem.load("secrets", "subscription")

# Deploys subscription-dropwizard app
unless tagged?("subscription-deployed")
  %w{ /data/apps /data/apps/subscription }.each do |dir|
    directory dir
  end
  template "/etc/init.d/subscription" do
    source "java.init.erb"
    mode 0755
  end

  bash "install-subscription-service" do
    code "chkconfig --add subscription"
    not_if "chkconfig --list | egrep '^subscription'"
  end

  remote_file "#{node[:subscription][:path]}/subscription.jar" do
    source "http://files.ihrdev.com/subscription-service/stage/subscriptions-service.jar/subscriptions-service-1.0.3.jar"
  end

  template "#{node[:subscription][:path]}/config.yml" do
    source "subscription.config.yml.erb"
    variables({
      :vindicia_creds => vindicia_creds
    })
  end

  service "subscription" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [ :enable, :restart ]
  end
  tag("subscription-deployed")
end
