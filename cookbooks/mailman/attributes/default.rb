default["mailman"]["mailman_email"] = "mailman@#{node['domain']}"
default["mailman"]["mailman_password"] = nil
default['mailman']['domain']="lists.#{node['domain']}"

default["mailman"]["list_creator"] = nil
default["mailman"]["site_pass"] = nil
