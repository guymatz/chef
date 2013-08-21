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
  unless tagged?("music-manager")

    cron_d "automated_takedown" do
        command "/data/apps/converter/current/bin/music_automated_takedown.sh > /dev/null 2>&1"
        minute "*"
        hour "7"
        day "*"
        month "*"
        weekday "*"
        user "root"
    end

    cron_d "performance_report" do
       command "/data/apps/converter/current/bin/transcoder_performance_report.sh > /dev/null 2>&1"
       minute "*"
       hour "7"
       day "*"
       month "*"
       weekday "*"
       user "root"
   end

    node[:encoders][:music][:manager][:startup_scripts].each do |script,tplate|
      template script do
        source tplate
        owner "root"
        mode "0755"
        variables({
          :num_scanners => 100 + node[:music_scanner][:num_processors],
          :type => "music"
        })
      end
#      service script.gsub(/\/etc\/init.d\//, "") do
#           action [:enable]
#      end
    end

    node[:encoders][:music][:manager][:monitor_scripts].each do |srpt|
      template "/usr/local/bin/#{srpt}.sh" do
        source "#{srpt}.erb"
        owner "root"
        mode 0755
        variables({
            :num_scanners => 100 + node[:music_scanner][:num_processors],
            :type => "music"
        })
      end

#    cron_d srpt do
#        command "/usr/local/bin/#{srpt}.sh > /dev/null 2>&1"
#        minute  "*/2"
#        hour  "*"
#        day   "*"
#        month   "*"
#        weekday "*"
#        user "root"
#      end
    end

            
    tag("music-manager")
  end
rescue
  untag("music-manager")
end
