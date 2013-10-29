begin

#   application "content-talk" do
#      path "/data/apps/content-talk/"
#      owner node[:encoder][:user]
#      group node[:encoder][:group]
#      repository node[:encftp][:incrond][:github_url]
#      restart_command "/usr/bin/incrontab -u converter /data/apps/content-talk/current/talk-incron/incrontab/filemonitors.incron.tab" 
#      deploy_key "encoder_deploy"
#      ssh_wrapper "/home/converter/encoder-wrap-ssh.sh"
#      revision "master"
#   end

    application "content-talk" do
        path "/data/apps/content-talk"
        repository node[:encftp][:incrond][:github_url]
        revision "master"
    end

    deploy "content-talk" do
        repo node[:encftp][:incrond][:github_url]
        symlinks.clear
        symlink_before_migrate.clear
        create_dirs_before_symlink.clear
        user "converter"
        deploy_to "/data/apps/content-talk"
        restart_command "/usr/local/bin/load_incron.sh"
        action  :deploy
    end

    service "incrond" do
        action [:enable, :start]
    end

end
