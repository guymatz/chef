deploy "converter" do
    repo  #{node[:encoders][:github_url]}
    deploy_to "/data/converter"
    migrate true
    remote "origin"
    user "converter"
    group "converter"
    action :deploy
    not_if "test -d /data/converter"
end
