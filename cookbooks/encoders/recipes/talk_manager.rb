begin
    unless tagged?("talk-manager")

    node[:encoders][:talk][:manager][:startup_scripts].each do |script,template|
        template script do
            source template
            owner "root"
            mode "0755"
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable]
        end
    end

    cron "talk_stagnant_file_check" do
        command "/data/apps/converter/current/bin/talk_stagnant_file_check.sh > /dev/null 2>&1"
        minute  "0"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
    end

    cron "talk_automated_takedown" do
        command "/data/apps/converter/current/bin/talk_automated_takedown.sh > /dev/null 2>&1"
        minute  "0"
        hour    "21"
        day     "*"
        month   "*"
        weekday "0"
    end

   tag("talk-manager")
   end
rescue
    untag("talk-manager")
end
