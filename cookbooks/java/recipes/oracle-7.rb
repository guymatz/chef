yum_package "jdk.x86_64" do
  flush_cache [ :before ]
  action [ :install ]
end

