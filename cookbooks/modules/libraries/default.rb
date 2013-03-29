def supported?
  case node['platform']
  when "ubuntu"
    # only work with upstart
    if node['platform_version'] >= "9.10"
      return true
    else
      return false
    end
  when "centos"
    return true
  else
    Chef::Log.info("Your platform isn't manage to save module changes")
    return false
  end
end
