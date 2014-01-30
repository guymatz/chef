
users_manage "imgsca" do
  group_id 2316
  action [ :remove, :create ]
end

sudo "imgsca" do
  group "imgsca"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
