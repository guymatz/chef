nagios_nrpecheck "check_talk_health" do
  command "sudo jruby --server -J-Djruby.jit.threshold=0 /data/apps/converter/current/bin/talk_health_check.rb -b"
end
