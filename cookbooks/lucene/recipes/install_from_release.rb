#
# Cookbook Name::       lucene
# Description::         Install From Release
# Recipe::              install_from_release
# Author::              Benjamin Black
#
# Copyright 2011, Benjamin Black
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'ark'

ark 'pylucene' do
  url   node[:pylucene][:release_url]
  version       node[:pylucene][:version]
  make_opts [ "CLASSPATH=/usr/share/java/ivy.jar" ]
  environment "PREFIX_PYTHON" => "/data/apps/names/venv"
  action        :install_with_make
  checksum      'c580d8e89f19170692b61e3865691a953c10a3e8acb06b6e2d68988d5649c183'
end


# include_recipe 'install_from'

# install_from_release('pylucene') do
#   release_url   node[:pylucene][:release_url]
#   #home_dir      node[:lucene][:home_dir]
#   version       node[:pylucene][:version]
#   action        [:install]
#   #has_binaries  [ 'bin/lucene' ]
#   #not_if{ ::File.exists?("#{node[:lucene][:install_dir]}/bin/lucene") }
#   not_if{ ::File.exists?("/usr/lib64/python2.7/site-packages/lucene-3.6.2-py2.7-linux-x86_64.egg/lucene/include/org/apache/pylucene") }
# end

# bash 'move storage-conf out of the way' do
#   user         'root'
#   cwd          node[:lucene][:home_dir]
#   code         'mv conf/storage-conf.xml conf/storage-conf.xml.orig'
#   not_if{  File.symlink?("#{node[:lucene][:home_dir]}/storage-conf.xml") }
#   only_if{ File.exists?( "#{node[:lucene][:home_dir]}/storage-conf.xml") }
# end

# link "#{node[:lucene][:conf_dir]}/storage-conf.xml" do
#   to "#{node[:lucene][:home_dir]}/conf/storage-conf.xml"
#   action        :create
#   only_if{ File.exists?( "#{node[:lucene][:conf_dir]}/storage-conf.xml") }
# end

# link "#{node[:lucene][:home_dir]}/lucene.in.sh" do
#   to "#{node[:lucene][:home_dir]}/bin/lucene.in.sh"
#   action        :create
# end

# include_recipe "lucene::bintools"
