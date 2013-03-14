

# Operations cookbook
# written by Jake Plimack <jakeplimack@clearchannel.com
#


case node['platform']
when "ubuntu","debian"
  default['operations']['packages'] = %w[ telnet dstat snmp net-tools htop procps nmap tree sysstat ]
when "redhat","centos","fedora","scientific","amazon"
  default['operations']['packages'] = %w[ telnet dstat net-snmp net-tools htop procps nmap tree sysstat diffutils ]
end

