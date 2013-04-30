


users_manage "amp" do
  group_id 2310
  action [ :remove, :create ]
end

sudo "amp" do
  group "amp"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
