#
# Cookbook Name:: rvm
# Recipe:: ruby_192

# Install deps as listed by recent revisions of RVM.
case node[:platform_family]
when "debian"
  packages = %w{ build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion }
when "rhel"
  packages = %w{ openssl curl git-core ruby-sqlite3 autoconf automake libtool bison subversion }
end


packages.each do |pkg|
  package pkg
end

node.default[:rvm][:ruby][:implementation] = 'ruby'
node.default[:rvm][:ruby][:version] = '1.9.2'
include_recipe "rvm::install"
