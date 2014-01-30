sudo "nagios-talk-nrpe" do
  user "nagios"
  group "nagios"
  commands ["/usr/local/bin/jruby"]
  runas "root"
  nopasswd true
end

nagios_nrpecheck "check_talk_health" do
  command "cd /data/apps/converter/current/bin && sudo /usr/local/bin/jruby --server -J-Djruby.jit.threshold=0 /data/apps/converter/current/bin/talk_health_check.rb -b"
end
