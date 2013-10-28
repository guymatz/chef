users_manage "mongod" do
  group_id 4009
  action [:remove, :create]
end

sudo "mongod" do
  user "mongod"
  commands ["/sbin/service mongod start", "/sbin/service mongod stop", "/sbin/service mongod2 start", "/sbin/service mongod2 stop"]
  runas "root"
  nopasswd true
end

file "/home/mongod/.ssh/config" do
  content <<-EOH
  ServerAliveInterval=2 
  Host * 
    StrictHostKeyChecking no
  EOH
  owner "mongod"
  group "mongod"
  mode "0400"
end
