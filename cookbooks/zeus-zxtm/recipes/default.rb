#
# Cookbook Name:: zeus-zxtm
# Recipe:: default
#
# Copyright 2013, Kos Media, LLC
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Get the Zeus tarball. You probably want to put this somewhere secure.

remote_file "/tmp/zeus-tarball.tgz" do
  source node[:zeus][:tarball_url]
  checksum node[:zeus][:checksum]
  mode 0644
end

# Get our encrypted data
enc_data = Chef::EncryptedDataBagItem.load("zeus", "items")

# Get the license from an encrypted data bag.
license_key = "/tmp/zeus-license-#{$$}.txt"
file license_key do
  owner "root"
  group "root"
  action :create
  content enc_data["license"]
end

# make helper files
template "/tmp/zinstall-script.txt" do
  source "zinstall-script.txt.erb"
  owner "root"
  mode 0700
end

template "/tmp/configure-script.txt" do
  source "configure-script.txt.erb"
  owner "root"
  mode 0700
  variables(
    :password => enc_data["password"],
    :license_key => license_key
  )
end

# Install if we haven't already, or if force_install is true
bash "install_zeus" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf zeus-tarball.tgz
    cd #{node[:zeus][:tarball_dir]}
    ./zinstall --replay-from=/tmp/zinstall-script.txt
    #{node[:zeus][:zeus_root]}/zxtm/configure --replay-from=/tmp/configure-script.txt    
  EOH
end
