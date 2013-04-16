include_recipe "users::dev"

sudo "dev-sysadmin" do
  group "dev"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
