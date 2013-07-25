application "converter" do
    path "#{node[:encoders][:deploy_path]}"
    deploy_key "encoder_deploy"
    repository node[:encoders][:github_url]
    revision "master"
end

deploy "converter" do
    repo node[:encoders][:github_url]
    symlink_before_migrate.clear
    create_dirs_before_symlink.clear
    purge_before_symlink.clear
    symlinks.clear
    user "converter"
    deploy_to "#{node[:encoders][:deploy_path]}"
    action :deploy
    ssh_wrapper "/home/converter/encoder-wrap-ssh.sh"
end
