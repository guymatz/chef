# quick install of rbel6 repo
# Created by Gregory Patmore <gregorypatmore@clearchannel.com>
# Created on 8/20/13

template "/etc/yum.repos.d/rbel6.repo" do
  source 'rbel6.repo.erb'
  owner "root"
  group "root"
  action :create
end