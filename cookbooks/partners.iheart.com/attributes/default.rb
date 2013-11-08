default[:partners][:repo] = 'git@github.com:iheartradio/partners.iheart.com.git'
default[:partners][:rev] = 'release'
default[:partners][:deploy_path] = '/data/apps/partners'
default[:partners][:user] = 'partners'
default[:partners][:group] = 'partners'
default[:partners][:deployer] = 'ihr-deployer'
default[:partners][:nginx_port] = "8080"
default[:partners][:gunicorn_port] = "8000"
default[:partners][:sqlite_path] = "/var/partners"

#default[:partners][:packages] = %w{ freetds python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel }

default[:partners][:packages] = %w{ python27 python27-libs python27-devel python27-test python27-tools python27-debuginfo libevent-devel unixODBC-devel freetds }


default["partners"]["config"]["prod"] = {
  :db_host => '10.5.43.148',
  :db_name => 'MSSQLDWH',
  :db_port => '1433',
  :db => 'RadioModel'
}
default["partners"]["config"]["_default"] = {
  :db_host => '10.5.43.148',
  :db_name => 'MSSQLDWH',
  :db_port => '1433',
  :db => 'RadioModel'
}
