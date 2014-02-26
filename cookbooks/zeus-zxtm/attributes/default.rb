#version to install

case chef_environment
when /^prod/
  default[:zeus][:tarball_url] = "http://files.ihrdev.com/ZeusTM_91_Linux-x86_64.tgz"
  default[:zeus][:tarball_dir] = "ZeusTM_91_Linux-x86_64"
  default[:zeus][:checksum] = "4e5a2f84ba7ec66b1acc9c06f07644a5aa268ea9742c52b771b229d9dc371cdc"
when /^stage/
  default[:zeus][:tarball_url] = "http://files.ihrdev.com/ZeusTM_95_Linux-x86_64.tgz"
  default[:zeus][:tarball_dir] = "ZeusTM_95_Linux-x86_64"
  default[:zeus][:checksum] = "9ae6b3778b9fe07c7d81cfe56095eaecbdbb57f220b07ef82e6a00a00dff7ed5"
end
default[:zeus][:zeus_root] = "/data/zeus"
default[:zeus][:force_install] = false
default[:zeus][:group] = "nobody"
default[:zeus][:user] = "nobody"
default[:zeus][:ec2] = "false"
