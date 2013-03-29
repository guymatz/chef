#
# Cookbook Name:: vmware
# Recipe:: tools
#
# Copyright 2012, Efactures
#
# Apache 2.0
#


if node.virtualization.system == 'vmware'

  execute "add_vmware_repo_key" do
    command "wget http://packages.vmware.com/tools/VMWARE-PACKAGING-GPG-KEY.pub -q -O- | apt-key add -"
    action :nothing
  end

  apt_repository "vmware-tools" do
    uri "http://packages.vmware.com/tools/esx/#{node.vmware.esx.tools.version}/ubuntu"
    distribution node['lsb']['codename']
    components ["main","restricted"]
    action :add
    notifies :run, resources(:execute => "add_vmware_repo_key"), :immediately
  end

  package "vmware-tools-esx-nox" do
    action :install
  end

  package "vmware-tools-esx-kmods-#{node.kernel.release}" do
    ignore_failure true # Vmware can be slow to release package for new updated kernel
    action :install
  end

end