users_manage "mysqlutil-sudo" do
  group_id 22314
  action [ :remove, :create ]
end

sudo "mysqlutil-sudo" do
  group "mysqlutil-sudo"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
