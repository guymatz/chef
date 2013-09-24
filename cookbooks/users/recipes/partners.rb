users_manage "partners" do
  group_id 4024
  action [ :remove, :create ]
end

sudo "partners" do
  group "partners"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
