node[:batchjobs][:packages].each do |batchjob_pkg|
  package batchjob_pkg
end

begin
  puts "entered deploy block"
  if not tagged?("batchjobs-deployed")
    directory "#{node[:batchjobs][:deploy_path]}" do
      owner "ihr-deployer"
      group "ihr-deployer"
      mode  "0755"
      recursive true
    end

    git "#{node[:batchjobs][:deploy_path]}" do
      repository node[:batchjobs][:repo]
      revision node[:batchjobs][:rev]
      action :sync
      notifies :run, 'bash[batchjob_perms]', :delayed
    end

    bash "batchjob_perms" do
      code "chown -R #{node[:batchjobs][:user]}.#{node[:batchjobs][:group]} #{node[:batchjobs][:deploy_path]};"
    end
    unless /development/ =~ node.chef_environment
      tag("batchjobs-deployed")
    end
  end
rescue
  untag("batchjobs-deployed")
end
