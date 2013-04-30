
users_manage "level3" do
  group_id 5026
  action [ :remove, :create ]
end

sudo "level3" do
  group "level3"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
