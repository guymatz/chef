sysadmins = search(:users, 'groups:sysadmin')
jenkins_users = search(:users, 'groups:jenkins')
jenkins_portal_users = sysadmins + jenkins_users

template "#{node['apache']['dir']}/htpasswd" do
    source "htpasswd.erb"
    owner       'apache'
    group       'apache'
    mode 0640
    variables(
              :sysadmins => jenkins_portal_users
              )
end
