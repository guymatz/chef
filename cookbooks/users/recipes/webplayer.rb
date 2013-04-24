
users_manage "webplayer" do
  group_id 2309
  action [ :remove, :create ]
end

sudo "webplayer" do
  group "webplayer"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
