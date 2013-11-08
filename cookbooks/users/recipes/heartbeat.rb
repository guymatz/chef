users_manage "heartbeat" do
  group_id 4028
  action :create
end

sudo "heartbeat" do
  group "heartbeat"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
