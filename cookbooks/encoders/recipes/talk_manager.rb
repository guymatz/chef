begin
    unless tagged?("talk-manager")

    node[:encoders][:talk][:manager][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
        end
        service script do
            action [:enable, :start]
        end
    end


   tag("talk-manager")
   end
rescue
    untag("talk-manager")
end
