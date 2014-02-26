
users_manage "admin_access" do
  group_id 2316
  action [ :remove, :create ]
end

sudo "admin_access" do
  group "admin_access"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
