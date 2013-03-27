#
# Cookbook Name:: mailman
# Provider:: list
#
# Copyright 2013, computerlyrik
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



include Chef::Mixin::ShellOut
include Opscode::OpenSSL::Password

action :create do
  if not exists?
    password = @new_resource.password ? @new_resource.password : secure_password
    execute "newlist #{@new_resource.name}" do
      command "newlist -q #{new_resource.name} #{new_resource.email} #{password}"
    end
    @new_resource.updated_by_last_action(true)
  end
  template "/etc/mailman/aliases/#{@new_resource.name}" do
    source "mailman_aliases.erb"
    variables ({:name => new_resource.name})
    cookbook "mailman"
  end
  execute "newaliases" do
    action :nothing
    subscribes :run, resources(:template => "/etc/mailman/aliases/#{new_resource.name}")
  end
end

action :delete do
  if exists?
    execute "rmlist #{@new_resource.name}"
    @new_resource.updated_by_last_action(true)
  end
  file "/etc/mailman/aliases/#{@new_resource.name}" do
    action :delete
  end
end

def exists?
  cmd = shell_out("list_lists")
  return cmd.stdout.downcase.include?(new_resource.name.downcase)
end
