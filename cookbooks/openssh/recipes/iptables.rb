
#do all the normal stuff plus this, we dont want to all of a sudden turn on iptables everywhere ssh is installed

include_recipe "iptables"
include_recipe "openssh"


iptables_rule "port_ssh"
