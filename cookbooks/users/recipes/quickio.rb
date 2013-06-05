
users_manage "quickio" do
  group_id 2313
  action [ :remove, :create ]
end

sudo "quickio" do
  group "quickio"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
