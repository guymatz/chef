# This recipe is meant to run on the stage v3 manager
#
# iad-stg-encmanager101.ihr
#
# 

begin
    unless tagged?("stage-v3")

    application "converter" do
        path "#{node[:encoders][:deploy_path]}"
        deploy_key "encoder_deploy"
        repository node[:encoders][:github_url]
        revision "qa"
    end

    deploy "converter" do
        repo node[:encoders][:github_url]
        symlink_before_migrate.clear
        create_dirs_before_symlink.clear
        purge_before_symlink.clear
        symlinks.clear
        revision "qa"
        user "converter"
        deploy_to "#{node[:encoders][:deploy_path]}"
        action :deploy
        ssh_wrapper "/home/converter/encoder-wrap-ssh.sh"
    end

   node[:v3_pkg].each do |pkg|
      yum_package pkg do
          arch "x86_64"
      end
    end

  node[:v3_gems].each do |gem,ver|
     gem_package gem do
       action :install
       options "--no-ri --no-rdoc"
       version ver
     end
  end

  node[:gems].each do |gem,ver|
     gem_package gem do
       action :install
       options "--no-ri --no-rdoc"
       version ver
     end
  end

    tag("stage-v3")
    end
rescue
    untag("stage-v3")
end
