users_manage "flume" do
  group_id 4020
  action :create
end

sudo "flume" do
  group "flume"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
