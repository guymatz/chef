begin
  unless tagged?("mixins-deployed")

      cron "mixin_status" do
        command "/data/apps/converter/status/mixin.sh > /dev/null 2>&1"
        minute  "3"
        hour    "*"
        day     "*"
        month   "*"
        weekday "*"
    end

   tag("mixins-deployed")
   end
rescue
    untag("talk-deployed")
end
