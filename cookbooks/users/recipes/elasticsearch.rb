
users_manage "elasticsearch" do
  group_id 4021
  action [ :remove, :create ]
end

sudo "elasticsearch" do
  group "elasticsearch"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
