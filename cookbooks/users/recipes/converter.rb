
users_manage "converter" do
  group_id 2306
  action [ :remove, :create ]
end

users_manage "prn-transcoding" do
  group_id 700
  action [ :remove, :create ]
end

users_manage "mixins-transcoding" do
  group_id 705
  action [ :remove, :create ]
end

users_manage "talk-transcoding" do
  group_id 702
  action [ :remove, :create ]
end

sudo "converter" do
  group "converter"
  commands ["ALL"]
  runas "converter"
  nopasswd true
end

sudo "converter" do
  group "converter"
  commands ["ALL"]
  runas "root"
  nopasswd true
}
