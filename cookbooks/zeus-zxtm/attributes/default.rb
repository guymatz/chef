default[:zeus][:tarball_url] = "http://example.com/zeus/Linux-x86_64.tgz"
# This will vary between versions and platforms, so needs to be set
default[:zeus][:tarball_dir] = "ZeusTM_90r3_Linux-x86_64"
default[:zeus][:checksum] = "94e65172855d85ceb37104535058ef9c3f658282"
default[:zeus][:zeus_root] = "/usr/local/zeus"
default[:zeus][:force_install] = false
default[:zeus][:group] = "nogroup"
default[:zeus][:user] = "nobody"
default[:zeus][:ec2] = "false"
