file "/etc/security/limits.d/cassandra.conf" do
  action :delete
end

file "/etc/security/limits.d/cassandra_root.conf" do
  action :delete
end
