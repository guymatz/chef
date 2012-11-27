
default[:ipplan][:app_name] = "ipplan"
default[:ipplan][:version] = "4.92b"
default[:ipplan][:package_url] = "http://sourceforge.net/projects/iptrack/files/ipplan/Release%204.92/ipplan-4.92b.tar.gz"
default[:ipplan][:install_path] = "/data/www/ipplan"


default[:ipplan][:user][:rhel] = "apache"

# Get checksum from http://sourceforge.net/projects/iptrack/files/ipplan/Release%204.92/
# MD5: 92f2499755e13260c06f51424cfce173
# SHA1: e161dbfb8d8f634a7f3be64cc877fc2ba165c729
default[:ipplan][:checksum] = "92f2499755e13260c06f51424cfce173"


# Apache & PHP Settings
default[:ipplan][:server_name] = "ipplan.ihrdev.com"
default[:ipplan][:server_aliases] = "ipplan"
case node['platform']
when "centos", "redhat", "suse", "fedora", "scientific", "amazon"
  default[:ipplan][:packages] = %w{ php-snmp zlib zlib-devel }
end

# Database Settings
default[:ipplan][:db_user] = "ipplan"
