#
#begin
#  unless tagged?("mixins-deployed")
#
#    node[:encoders][:filemonitor][:mixins_links].each do |target,src|
#        link target do
#            to src
#        end
#    end
#
#   tag("mixins-deployed")
#   end
#rescue
#    untag("talk-deployed")
#end
