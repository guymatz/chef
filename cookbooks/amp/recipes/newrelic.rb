begin
  puts "Deploying New Relic"
  unless tagged?("new-relic-deployed")
  service "tomcat" do
    action :stop
  end

  remote_file "#{node[:tomcat7][:install_path]}/#{node[:amp][:new_relic_filename]}#{node[:amp][:new_relic_version]}.zip" do
    source "#{node[:amp][:new_relic_url]}/#{node[:amp][:new_relic_filename]}#{node[:amp][:new_relic_version]}.zip"
    mode "0644"
    action :create_if_missing
  end

  bash "Extract NewRelic" do
    cwd "#{node[:tomcat7][:install_path]}"
    code "/usr/bin/unzip -u #{node[:tomcat7][:install_path]}/#{node[:amp][:new_relic_filename]}#{node[:amp][:new_relic_version]}.zip"
  end

  template "#{node[:amp][:new_relic_directory]}/newrelic.yml" do
    source "newrelic.yml.erb"
    mode "0644"
  end

  template "#{node[:tomcat7][:install_path]}/bin/catalina.sh" do
    source "catalina.sh.erb"
    mode "0755"
  end

  bash "Start Tomcat" do
    code "/etc/init.d/tomcat start"
  end

  tag("new-relic-deployed")
end
rescue
  untag("new-relic-deployed")
end
