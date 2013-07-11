users_manage "flume" do
  group_name "tomcat"
  group_id 91
  action [ :remove, :create ]
end

sudo "flume" do
  group "flume"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
