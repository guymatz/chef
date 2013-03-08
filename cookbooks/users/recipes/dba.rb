
# Searches data bag "users" for groups attribute "dba".
# Places returned users in Unix group "dba" with GID 2304.
users_manage "dba" do
  group_id 2304
  action [ :remove, :create ]
end

