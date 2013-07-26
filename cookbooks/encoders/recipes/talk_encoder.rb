begin
    unless tagged?("talk-encoder")

    node[:encoders][:talk][:encoder][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable, :start]
        end
    end


   tag("talk-encoder")
   end
rescue
    untag("talk-encoder")
end
