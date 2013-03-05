
if node.platform?("centos")
  template "/etc/yum.repos.d/iheart.repo" do
    owner "root"
    group "root"
    mode "0644"
    source "iheart.repo.erb"
    variables ({
                 :yum_server => node[:yum][:server]
               })
    only_if "test -d /etc/yum.repos.d"
  end
end

