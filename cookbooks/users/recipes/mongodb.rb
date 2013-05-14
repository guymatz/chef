users_manage "mongodb" do
  group_id 4099
  action [:remove, :create]
end

sudo "mongodb" do
  group "mongodb"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
