users_manage "nagios-sudo" do
  group_id 22315
  action [ :remove, :create ]
end

sudo "nagios-sudo" do
  group "nagios-sudo"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
