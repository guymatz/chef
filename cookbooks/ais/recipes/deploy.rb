node[:ais][:sysctl_settings].each do |k,v|
  sysctl k do
    value v
  end
end

user_ulimit 'root' do
  filehandle_limit 1048576
end

ais "server" do
  cluster_name node[:ais][:cluster_name]
  ais_type node[:ais][:ais_type]
  config_site '10.5.57.10:8080/cobbler/pub'
  version node[:ais][:version]
end
