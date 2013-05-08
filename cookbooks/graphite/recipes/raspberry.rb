#
# Cookbook Name:: graphite
# Recipe:: raspberry
#
# Installs IHR custom web landing page for our graphite servers
#
# drop a github private deploy key for status-deploy
deploy_keys = Chef::EncryptedDataBagItem.load("keys", "status-deploy")
directory "/root/.ssh" do
    recursive true
    mode "0700"
end

file "/root/.ssh/deploy" do
    mode "0400"
    content deploy_keys['private_key']
    :create_if_missing
end

file "/root/.ssh/config" do
    mode "0755"
    content <<-EOH
        Host *github.com *.ihr iad-search*
        IdentityFile "/root/.ssh/deploy"
        StrictHostKeyChecking no
    EOH
end

git node[:graphite][:web_install_path] do
    repository node[:graphite][:repo]
    revision "HEAD"
    action :sync
    not_if "test -d #{node[:graphite][:web_install_path]}/.git"
end
