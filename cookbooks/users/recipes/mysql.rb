users_manage "mysql" do
  group_id 4023
  action [:create]
end

file "/home/mysql/.ssh/config" do
  content <<-EOH
  ServerAliveInterval=2 
  Host * 
    StrictHostKeyChecking no
  EOH
  owner "mysql"
  group "mysql"
  mode "0400"
end
