# Diamond Install recipe

case node['diamond']['install_type']
  when :apt, :rpm
    if not ::File.exists?('/usr/bin/diamond') or node['diamond']['force_install']
      package "diamond" do
        action :install
        version node['diamond']['version']
        notifies :start, "service[diamond]"
      end
    end

  when :deb
    # Compare diamond installed version against what we really want.
    wanted_diamond_version = node['diamond']['version']
    installed_diamond_version=`/usr/bin/dpkg-query -W -f='${Version}' diamond`

    if $?.to_i != 0
      Chef::Log.info "[diamond] Diamond is not currently installed."
      install_diamond = true
      installed_diamond_version = nil
    else
      `/usr/bin/dpkg --compare-versions #{installed_diamond_version} lt #{wanted_diamond_version}`
      $?.to_i == 0 ? install_diamond = true : install_diamond = false

      Chef::Log.info "[diamond] We want Diamond version #{wanted_diamond_version}."
      Chef::Log.info "[diamond] Currently installed Diamond version is #{installed_diamond_version}."
    end

    if install_diamond or node['diamond']['force_install']
      Chef::Log.info "[diamond] Installing Diamond version #{wanted_diamond_version}."

      node['diamond']['required_debian_packages'].collect do |pkg|
        package pkg
      end

      directory "create_temp_git_path" do
        path node['diamond']['git_tmp']
        action :create
        recursive true
      end

      if node['diamond']['version'] != 'master' then
            node.override['diamond']['git_reference'] = "v#{node['diamond']['version']}"
      else
            node.override['diamond']['git_reference'] = node['diamond']['version']
      end

      git node['diamond']['git_path'] do
        repository node['diamond']['git_repository_uri']
        reference node['diamond']['git_reference']
        action :checkout
        not_if { ::File.exists?("#{node['diamond']['git_path']}/setup.py") }
      end

      execute "build diamond" do
        cwd node['diamond']['git_path']
        command "make builddeb"
      end

      package "diamond" do
        source "#{node['diamond']['git_path']}/build/diamond_#{node['diamond']['package_version']}_all.deb"
        provider Chef::Provider::Package::Dpkg
        version node['diamond']['package_version']
        options "--force-confnew,confmiss"
        action :install
      end

      if installed_diamond_version
        service "diamond" do
          provider Chef::Provider::Service::Upstart
          action :restart
        end
      else
        service "diamond" do
          provider Chef::Provider::Service::Upstart
          action :start
        end
      end

      directory "clean up temp git path" do
        path node['diamond']['git_tmp']
        action :delete
        recursive true
      end
    else
      Chef::Log.info "[diamond] Diamond is up to date."
    end
end
