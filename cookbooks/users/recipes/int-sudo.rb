users_manage "int-sudo" do
  group_id 2319
  action [ :create ]
end

sudo "int-sudo" do
  group "int-sudo"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
