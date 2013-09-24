users_manage "partners" do
  group_id 4022
  action [ :remove, :create ]
end

sudo "partners" do
  group "partners"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
