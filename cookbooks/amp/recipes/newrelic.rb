unless tagged?("new-relic-depoyed")
  service "tomcat" do
    action :stop
  end
  
  remote_file "#{node[:tomcat7][:install_path]}/#{node[:amp][:new_relic_filename]}#{node[:amp][:new_relic_version]}.zip" do
    source "#{node[:amp][:new_relic_url]}/#{node[:amp][:new_relic_filename]}#{node[:amp][:new_relic_version]}.zip"
    mode "0644"
  end

  bash "Extract NewRelic" do
    code "/usr/bin/unzip #{node[:tomcat7][:install_path]}/#{node[:amp][:new_relic_filename]}#{node[:amp][:new_relic_version]}.zip"
  end

  template "#{node[:amp][:new_relic_directory]}/newrelic.yml"
    source "newrelic.yml.erb"
    mode "0644"
  end

  
