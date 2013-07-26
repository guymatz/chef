


users_manage "pnp" do
  group_id 4012
  action [ :remove, :create ]
end

sudo "pnp" do
  group "pnp"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
