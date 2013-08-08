begin
    unless tagged?("talk-encoder")

    node[:encoders][:talk][:encoder][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
            variables({
               :num_converters => node[:talk_converters][:num_processors]
            })
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable, :start]
        end
    end

    template "/usr/local/bin/talk_encoder_check.sh" do
        source node[:encoders][:talk][:encoder][:monitor_scripts]
        owner "root"
        mode "0755"
        variables({
            :num_converters => node[:talk_converters][:num_processors]
        })
    end
    cron_d "talk_encoder_check" do
        command "/usr/local/bin/talk_encoder_check.sh> /dev/null 2>&1"
        minute  "*/2"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
        user "root"
    end


   tag("talk-encoder")
   end
rescue
    untag("talk-encoder")
end
