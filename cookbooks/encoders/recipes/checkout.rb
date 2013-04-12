application "converter" do
    path "#{node[:encoders][:deploy_path]}"
    repository node[:encoders][:github_url]
    revision "master"

end
