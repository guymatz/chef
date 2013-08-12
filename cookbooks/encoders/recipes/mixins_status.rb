begin
  unless tagged?("mixins-status-deployed")
    service "nagios-nrpe-server" do
        supports :start => true, :stop => true, :status => true
    end

    cron_d "mixin_status" do
        command "/data/apps/converter/status/mixin.sh > /dev/null 2>&1"
        minute  "*/3"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
        user "root"
    end

    template "#{node[:nagios][:plugin_dir]}/check_addins.sh" do
        source "check_addins.erb"
        owner node[:nagios][:user]
        group node[:nagios][:group]
        mode "755"
    end

    nagios_nrpecheck "Addins-Stale-Feeds-Percentage" do
      command "#{node[:nagios][:plugin_dir]}/check_addins.sh"
        action :add
    end

   tag("mixins-status-deployed")
   end
rescue
    untag("mixins-status-deployed")
end
