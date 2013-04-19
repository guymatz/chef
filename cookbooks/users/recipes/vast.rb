
users_manage "vast" do
  group_id 2307
  action [ :remove, :create ]
end

sudo "vast" do
  group "vast"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
