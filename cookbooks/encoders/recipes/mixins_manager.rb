begin
    unless tagged?("mixins-manager")

    directory "/var/run/manager" do
      owner 'converter'
      group 'converter'
      action :create
    end

    node[:encoders][:mixins][:manager][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable]
        end
    end


   tag("mixins-manager")
   end
rescue
    untag("mixins-manager")
end
