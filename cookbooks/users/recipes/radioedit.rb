users_manage "radioedit" do
  group_id 2320
  action [ :remove, :create ]
end

sudo "radioedit" do
  group "radioedit"
  commands ["ALL"]
  runas "root"
  nopasswd true
end