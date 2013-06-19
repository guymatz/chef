
begin
  unless tagged?("ingestion-deployed")

    template "#{node[:tomcat7][:install_path]}/bin/setenv.sh" do
          source "setenv.sh.erb"
          owner node[:tomcat7][:user]
          group node[:tomcat7][:group]
          mode "0755"
              variables({
                        })
    end

    template "#{node[:tomcat7][:install_path]}/bin/catalina.sh" do
          source "catalina.sh.erb"
          owner node[:tomcat7][:user]
          group node[:tomcat7][:group]
          mode "0755"
              variables({
                        })
    end

    package "jakarta-commons-daemon-jsvc" do
          action :install
    end


    node[:encoders][:filemonitor][:static_files].each do |dest,src|
        remote_directory dest do
            source src
            mode 0755
    end

#    execute "webapp_dir" do
#        command "mkdir -p #{node[:tomcat7][:install_path]}/webapps/"
#        not_if { ::File.exists?("#{node[:tomcat7][:install_path]}/webapps/ingester")} 
#    end

    cookbook_file "#{node[:tomcat7][:install_path]}/webapps/ingester.war" do
        source node[:encoders][:filemonitor][:ingester_war]
        mode 0555
        action :create_if_missing
    end

    cookbook_file "#{node[:tomcat7][:install_path]}/lib/postgresql-9.0-801.jdbc4.jar" do
        source node[:encoders][:filemonitor][:postgres_jar]
        mode 0644
        action :create_if_missing
    end

    directory "filemonitor_log" do
        owner "tomcat"
        group "tomcat"
        mode 0644
        action :create
        not_if { ::File.exists?(node[:encoders][:filemonitor][:logdir])} 
    end

    template "/etc/init.d/fileMonitorService" do
        source "fileMonitorService.erb"
        owner "root"
        mode "0755"
    end

    service "fileMonitorService" do
        action [:enable, :start]
    end

    end

   tag("ingestion-manager-deployed")
   end
rescue
    untag("ingestion-manager-deployed")
end
