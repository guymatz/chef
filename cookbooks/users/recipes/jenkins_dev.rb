users_manage "jenkins_dev" do
  group_id 2315
  action [ :remove, :create ]
end

sudo "jenkins_dev" do
  group "jenkins_dev"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
