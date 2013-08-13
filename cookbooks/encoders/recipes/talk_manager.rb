# This recipe is meant to run on the talk manager boxes, currently
#
# iad-encmanager103.ihr
#
# Purpose:
# Copy startup scripts 
# Install cron jobs for existing scripts (residing in code checkout directory)
# Install nagios check to watch for scanner processes
# 

begin
    unless tagged?("talk-manager")

    node[:encoders][:talk][:manager][:startup_scripts].each do |script,tplate|
        template script do
            source tplate
            owner "root"
            mode "0755"
            variables({
                :num_converters => node[:talk_scanner][:num_processors]
            })
        end
        service script.gsub(/\/etc\/init.d\//, "") do
            action [:enable]
        end
    end

   node[:encoders][:talk][:manager][:monitor_scripts].each do |srpt|
        log("1-----> looping through #{srpt}.")
         template "/usr/local/bin/#{srpt}.sh" do
             log(srpt)
             source "#{srpt}.sh"
             owner "root"
             mode "0755"
#             variables({
#                 :num_scanners => node[:talk_scanners][:num_processors]
#            })
        end
    end
#        cron_d srpt do
#            command "/usr/local/bin/#{srpt}.sh > /dev/null 2>&1"
#            minute  "*/2"
#            hour    "*"
#            day     "*"
#            month   "*"
#            weekday "*"
#            user "root"
#        end
#    end

    cron_d "talk_stagnant_file_check" do
        command "/data/apps/converter/current/bin/talk_stagnant_file_check.sh > /dev/null 2>&1"
        minute  "0"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
        user "root"
    end

    cron_d "talk_automated_takedown" do
        command "/data/apps/converter/current/bin/talk_automated_takedown.sh > /dev/null 2>&1"
        minute  "0"
        hour    "21"
        day     "*"
        month   "*"
        weekday "0"
        user "root"
    end

   tag("talk-manager")
   end
rescue
    untag("talk-manager")
end
