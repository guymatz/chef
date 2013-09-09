begin
    unless tagged?("music-encoder")

    node[:encoders][:music][:encoder][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
            variables({
               :num_converters => 100 + node[:music_converters][:num_processors]
            })
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable, :start]
        end
    end

    cron_d "music_encoder_check" do
        command "/usr/local/bin/music_encoder_check.sh> /dev/null 2>&1"
        minute  "*/2"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
        user "root"
    end


    template "/usr/local/bin/music_encoder_check.sh" do
        source node[:encoders][:music][:encoder][:monitor_scripts]
        owner "root"
        mode "0755"
        variables({
            :num_converters => 100 + node[:music_converters][:num_processors],
            :type => "music"
        })
    end


   tag("music-encoder")
   end
rescue
    untag("music-encoder")
end
