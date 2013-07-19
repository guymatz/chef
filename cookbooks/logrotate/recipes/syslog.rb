logrotate_app "syslog" do
  path '/var/log/syslog '\
       '/var/log/cron '\
       '/var/log/maillog '\
       '/var/log/messages '\
       '/var/log/secure '\
       '/var/log/spooler '\
       '/var/log/daemon.log '\
       '/var/log/mail.*'
  options ["sharedscripts", "compress"]
  postrotate "/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true"
  frequency "daily"
  rotate 7
end
