
# Searches data bag "users" for groups attribute "encoder".
# Places returned users in Unix group "encoder" with GID 2306.
users_manage "encoder" do
  group_id 2305
  action [ :remove, :create ]
end

