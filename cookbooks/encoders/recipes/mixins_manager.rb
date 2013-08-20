begin
    unless tagged?("mixins-manager")


    node[:encoders][:filemonitor][:mixins_links].each do |target,src|
        link target do
            to src
        end
    end

    node[:encoders][:mixins][:manager][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
            variables({
               :num_converters => 100 + node[:mixins_converters][:num_processors]
            })
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable]
        end
    end

    template "/usr/local/bin/mixin_encoder_check.sh" do
        source node[:encoders][:mixin][:encoder][:monitor_scripts]
        owner "root"
        mode "0755"
        variables({
            :num_converters => 100 + node[:mixin_converters][:num_processors],
            :type => "mixin"
        })
    end
    cron_d "mixin_encoder_check" do
        command "/usr/local/bin/mixin_encoder_check.sh> /dev/null 2>&1"
        minute  "*/2"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
        user "root"
    end

   tag("mixins-manager")
   end
rescue
    untag("mixins-manager")
end
