
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
default[:ipplan][:server_aliases] = "ipplan ipplan.ihr"
case node['platform']
when "centos", "redhat", "suse", "fedora", "scientific", "amazon"
  default[:ipplan][:packages] = %w{ php-snmp zlib zlib-devel }
  default[:ipplan][:scripts][:packages] = %w{ perl-DBI perl-DBD-MySQL libxslt }
when "debian"
  default[:ipplan][:packages] = %w{ php5-snmp zlib1g zlib1g-dev }
  default[:ipplan][:scripts][:packages] = %w{ libdbi-perl libdbd-mysql-perl libdbd-mysql libxslt1.1 libwww-perl php5-mysql xsltproc netcat6 }
end

# Database Settings
default[:ipplan][:db_user] = "ipplan"

# Script Settings for Exporting

default[:ipplan][:staging_dir] = "/staging_bind"
default[:ipplan][:scripts_dir] = "/usr/local/bin/ipplan"
default[:ipplan][:ipplan_url] = "ipplan.ihrdev.com"
default[:ipplan][:ipplan_user] = "ops-auto"


default[:ipplan][:fwd_zones] = %w{ ihr prod.ihr dev.ihr }

default[:ipplan][:repo] = "git@github.com:iheartradio/ipplan-autogen.git"
