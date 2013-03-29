
# Searches data bag "users" for groups attribute "qa".
# Places returned users in Unix group "qa" with GID 2305.
users_manage "qa" do
  group_id 2305
  action [ :remove, :create ]
end

