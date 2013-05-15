
users_manage "facebook" do
  group_id 2311
  action [ :remove, :create ]
end

sudo "facebook" do
  group "facebook"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
