default['diamond']['required_python_packages'] = { "configobj" => "4.7.2","psutil" => "0.6.1"}
default['diamond']['required_debian_packages'] = ["pbuilder","python-mock","python-configobj","cdbs","python-pysnmp4"]
default['diamond']['git_tmp'] = "/mnt/git"
default['diamond']['git_path'] = "#{node['diamond']['git_tmp']}/Diamond"
default['diamond']['git_repository_uri'] = "https://github.com/BrightcoveOS/Diamond.git"
