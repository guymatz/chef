include_recipe "logrotate"

include_recipe "tomcat7"

begin

    template "#{node[:tomcat7][:install_path]}/bin/setenv.sh" do
          source "setenv.sh.erb"
          owner node[:tomcat7][:user]
          group node[:tomcat7][:group]
          mode "0755"
              variables({
                        })
    end

    unless tagged?("ingestion-manager-deployed")
        package "jakarta-commons-daemon-jsvc" do
          action :install
    end


    node[:encoders][:filemonitor][:static_files].each do |dest,src|
        remote_directory "#{dest}" do
            source "#{src}"
            mode 0755
        end
    end

    execute "webapp_dir" do
        command "mkdir -p #{node[:tomcat7][:install_path]}/webapps/ingester"
        not_if { ::File.exists?("#{node[:tomcat7][:install_path]}/webapps/ingester")} 
    end

    cookbook_file "#{node[:tomcat7][:install_path]}/webapps/ingester/ingester.war" do
        source "#{node[:encoders][:filemonitor][:ingester_war]}"
        mode 0555
    end

    directory "filemonitor_log" do
        owner "tomcat"
        group "tomcat"
        mode 0644
        action :create
        not_if { ::File.exists?("#{node[:encoders][:filemonitor][:logdir]}")} 
    end

    template "/etc/init.d/fileMonitorService" do
        source "fileMonitorService.erb"
        owner "root"
        mode "0755"
    end

    service "fileMonitorService" do
        action [:enable, :start]
    end

    tag("ingestion-manager-deployed")
    end
rescue
    untag("ingestion-manager-deployed")
end

