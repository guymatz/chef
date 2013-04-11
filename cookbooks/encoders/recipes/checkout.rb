deploy "converter" do
  repo  node[:encoders][:github_url]
  branch "master"
  deploy_to "#{node[:encoders][:deploy_path]}"
  migrate true
  remote "origin"
  user "converter"
  group "converter"
  action :deploy
end
