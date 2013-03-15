
users_manage "attivio" do
  group_id 2303
  action [ :remove, :create ]
end

sudo "attivio" do
  group "attivio"
  commands ["ALL"]
  runas "attivio"
  nopasswd true
end
