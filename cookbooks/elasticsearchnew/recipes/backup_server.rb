
# Required for dir on NFS server to receive rsync jobs from ES server
directory node[:elasticsearchnew][:backup_target] do
  owner "root"
  group "root"
  recursive true
  mode "1777"
end
