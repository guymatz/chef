


users_manage "sonos-sudo" do
  group_id 2321
  action [ :remove, :create ]
end

sudo "sonos-sudo" do
  group "sonos-sudo"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
