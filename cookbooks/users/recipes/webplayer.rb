
users_manage "webplayer" do
  group_id 2308
  action [ :remove, :create ]
end

sudo "webplayer" do
  group "webplayer"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
