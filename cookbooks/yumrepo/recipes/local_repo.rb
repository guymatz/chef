# Create local repo

node[:yum][:local][:dirs].each do |dir|
  directory dir do
    action :create
    recursive true
    owner 'root'
    group 'root'
    mode '755'
  end
end

node[:yum][:local][:dirs].each do |repo|
  bash repo do
    user "root"
    cwd repo
    code <<-EOH
    createrepo --update -d .
    EOH
  end
end
