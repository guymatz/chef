users_manage "flume" do
  group_name "tomcat"
  action [ :remove, :create ]
end

sudo "flume" do
  group "flume"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
