# This recipe sets up the check for top 20 stations
# Need sudo access to run the check
sudo "nagios" do
  user "nagios"
  runas "root"
  commands ["#{node[:encoders][:deploy_path]}/current/bin/mixin_nagios_plugin.rb"]
end

nagios_nrpecheck "Check-Top20" do
  command "sudo #{node[:encoders][:deploy_path]}/current/bin/mixin_nagios_plugin.rb"
end
