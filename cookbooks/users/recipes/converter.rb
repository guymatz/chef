
users_manage "converer" do
  group_id 2307
  action [ :remove, :create ]
end

sudo "converter" do
  group "converter"
  commands ["ALL"]
  runas "converter"
  nopasswd true
end
