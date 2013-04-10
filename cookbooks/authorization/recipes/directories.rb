if node['network']['interfaces'].has_key?('bond0.260:0')
 link "/u03/pg/indexes" do
    to "/data/index"
 end

 directory "/data/dbdata" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

 directory "/data/wal" do
   owner "postgres"
   group "postgres"
   mode 0755
   action :create
 end

 directory "/data/index" do
   owner "postgres"
   group "postgres"
   mode 0755
   action :create
 end

 directory "/data/backups" do
   owner "postgres"
   group "postgres"
   mode 0755
   action :create
 end

 directory "/data/archwal" do
   owner "postgres"
   group "postgres"
   mode 0755
   action :create
 end

 directory "/u03" do
   owner "postgres"
   group "postgres"
   mode  0775
   action :create
 end

 directory "/u03/pg" do
   owner "postgres"
   group "postgres"
   mode  0775
   action :create
 end

 directory "/data/sql-reports" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

 directory "/data/sql-reports/#{node[:fqdn]}" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

 directory "/data/sql-reports/tmp" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

 directory "/data/sql-reports/tmp/#{node[:fqdn]}" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

 directory "/data/backups" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

 directory "/data/backups/#{node[:fqdn]}" do
   owner "postgres"
   group "postgres"
   mode 0700
   action :create
 end

end
