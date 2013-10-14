users_manage "hadoop" do
  group_id 4025
  action :create
end

sudo "hadoop" do
  group "hadoop"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
