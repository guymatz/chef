# Load sensitive info from encrypted data bag
vindicia_creds = Chef::EncryptedDataBagItem.load("secrets", "subscription")

# Deploys subscription-dropwizard app
unless tagged?("subscription-deployed")
  node[:subscription][:dirs].each do |dir|
    directory dir do
      owner "amp"
      group "amp"
    end
  end
  template "/etc/init.d/subscription" do
    source "java.init.erb"
    variables({
      :app => "subscription"
    })
    mode 0755
  end

  bash "install-subscription-service" do
    code "chkconfig --add subscription"
    not_if "chkconfig --list | egrep '^subscription'"
  end

  remote_file "#{node[:subscription][:path]}/subscription.jar" do
    owner "amp"
    group "amp"
    source node[:subscription][:jar_download]
  end

  remote_file "#{Chef::Config[:file_cache_path]}/subscription.config.yml.erb" do
    owner "amp"
    group "amp"
    source node[:subscription][:yml_download]
  end

  template "#{node[:subscription][:path]}/config.yml" do
    local true
    source "#{Chef::Config[:file_cache_path]}/subscription.config.yml.erb"
    variables({
      :vindicia_creds => vindicia_creds
    })
    owner "amp"
    group "amp"
  end

  service "subscription" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [ :enable, :restart ]
  end
  tag("subscription-deployed")
end
