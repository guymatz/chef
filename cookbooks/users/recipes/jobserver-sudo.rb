users_manage "jobserver-sudo" do
  group_id 2314
  action [ :remove, :create ]
end

sudo "jobserver-sudo" do
  group "jobserver-sudo"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
