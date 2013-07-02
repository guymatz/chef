logrotate_app "syslog" do
  path  <<-eos
          /var/log/cron 
          /var/log/maillog
          /var/log/messages
          /var/log/secure
          /var/log/spooler
          /var/log/daemon.log
          /var/log/mail.*"
        eos
  options ["sharedscripts"]
  postrotate "/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true"
end
