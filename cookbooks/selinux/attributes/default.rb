



case node['platform']
when "centos", "redhat", "fedora"
  default[:selinux][:packages] = %w{ policycoreutils setroubleshoot selinux-policy-targeted selinux-policy libselinux libselinux-python libselinux-utils policycoreutils policycoreutils-python setroubleshoot setroubleshoot-server setroubleshoot-plugins }
end
