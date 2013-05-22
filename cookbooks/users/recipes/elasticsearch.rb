
users_manage "elasticsearch" do
  group_id 2312
  action [ :remove, :create ]
end

sudo "elasticsearch" do
  group "elasticsearch"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
