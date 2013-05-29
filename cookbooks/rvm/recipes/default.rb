#
# Cookbook Name:: rvm
# Recipe:: default

# Make sure that the package list is up to date on Ubuntu/Debian.
include_recipe "apt" if [ 'debian', 'ubuntu' ].member? node[:platform]

# Make sure we have all we need to compile ruby implementations:
package "curl"
package "git-core"
include_recipe "build-essential"


# Install deps as listed by recent revisions of RVM.
case node[:platform_family]
when "debian"
  packages = %w{ build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion libreadline-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev libtool }
when "rhel"
  packages = %w{ openssl curl git-core ruby-sqlite3 autoconf automake libtool bison subversion }
end

packages.each do |pkg|
  package pkg
end

# clean up rvm stuff
# This is mostly to save inode space
execute "rvm-cleanup" do
  user "root"
  command "/usr/local/rvm/bin/rvm cleanup sources"
  action :nothing
end

bash "installing system-wide RVM stable" do
  user "root"
  code "bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)"
  not_if "test -e /usr/local/rvm/bin/rvm"
end

bash "upgrading to RVM head" do
  user "root"
  code "/usr/local/rvm/bin/rvm update --head ; /usr/local/rvm/bin/rvm reload"
  only_if { node[:rvm][:version] == :head }
  only_if { node[:rvm][:track_updates] }
end

bash "upgrading RVM stable" do
  user "root"
  code "/usr/local/rvm/bin/rvm update ; /usr/local/rvm/bin/rvm reload"
  only_if { node[:rvm][:track_updates] }
end

#cookbook_file "/etc/profile.d/rvm.sh" do
#  owner "root"
#  group "root"
#  mode 0755
#end

cookbook_file "/usr/local/rvm/bin/rvm-gem.sh" do
  owner "root"
  group "root"
  mode 0755
end

# set this for compatibilty with other people's recipes
node.default[:languages][:ruby][:ruby_bin] = find_ruby
