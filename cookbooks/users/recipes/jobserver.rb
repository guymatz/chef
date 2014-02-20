users_manage "jobserver" do
  group_id 2308
  action [ :remove, :create ]
end

sudo "dba" do
  group "dba"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
