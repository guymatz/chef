
unless node.run_list.include?("recipe[rsyslog::nfs]")
  node.run_list << 'recipe[rsyslog::nfs]'
end

nfs_export node[:rsyslog][:log_dir] do
  network "10.0.0.0/8"
  writeable false
  sync true
  options ["no_root_squash","insecure"]
end

