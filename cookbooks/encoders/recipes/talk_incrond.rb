begin

   application "content-talk" do
      path "/data/apps/content-talk/"
      owner node[:encoder][:user]
      group node[:encoder][:group]
      repository node[:encftp][:incrond][:github_url]
      restart_command "/usr/bin/incrontab -u converter /data/apps/content-talk/current/talk-incron/incrontab/filemonitors.incron.tab" 
      revision "master"
   end

    service "incrond" do
        action [:enable, :start]
    end

end
