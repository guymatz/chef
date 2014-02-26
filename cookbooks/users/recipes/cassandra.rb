


users_manage "cassandra" do
  group_id 2317
  action [ :remove, :create ]
end

sudo "cassandra" do
  group "cassandra"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
