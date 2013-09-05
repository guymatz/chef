begin
    unless tagged?("talk-incrond")

   application "content-talk" do
      path "/data/apps/content-talk/"
      owner node[:encoder][:user]
      group node[:encoder][:group]
      repository node[:encftp][:incrond][:github_url]
      revision "master"
   end

    service "incrond" do
        action [:enable, :start]
    end

    tag("talk-incrond")
    end
rescue
    untag("talk-incrond")
end
