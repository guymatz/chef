sysctl "kernel.sysrq" do
    value 0
end
sysctl "kernel.core_uses_pid" do
    value 1
end
sysctl "kernel.msgmnb" do
    value 65536
end
sysctl "kernel.msgmax" do
    value 65536
end
sysctl "kernel.shmmax" do
    value 33792937984
end
sysctl "kernel.shmall" do
    value 8250229
end
sysctl "net.ipv4.ip_forward" do
    value 0
end
sysctl "net.ipv4.conf.all.send_redirects" do
    value 0
end
sysctl "net.ipv4.conf.default.send_redirects" do
    value 0
end
sysctl "net.ipv4.tcp_max_syn_backlog" do
    value 1280
end
sysctl "net.ipv4.icmp_echo_ignore_broadcasts" do
    value 1
end
sysctl "net.ipv4.conf.all.accept_source_route" do
    value 0
end
sysctl "net.ipv4.conf.all.accept_redirects" do
    value 0
end
sysctl "net.ipv4.conf.all.secure_redirects" do
    value 0
end
sysctl "net.ipv4.conf.all.log_martians" do
    value 1
end
sysctl "net.ipv4.conf.default.accept_source_route" do
    value 0
end
sysctl "net.ipv4.conf.default.accept_redirects" do
    value 0
end
sysctl "net.ipv4.conf.default.secure_redirects" do
    value 0
end
sysctl "net.ipv4.icmp_echo_ignore_broadcasts" do
    value 1
end
sysctl "net.ipv4.icmp_ignore_bogus_error_responses" do
    value 1
end
sysctl "net.ipv4.tcp_syncookies" do
    value 1
end
sysctl "net.ipv4.conf.all.rp_filter" do
    value 1
end
sysctl "net.ipv4.conf.default.rp_filter" do
    value 1
end
sysctl "net.ipv4.tcp_timestamps" do
    value 0
end
sysctl "kernel.exec-shield" do
    value 1
end
sysctl "kernel.randomize_va_space" do
    value 1
end
sysctl "net.core.rmem_default" do
    value 262144
end
sysctl "net.core.wmem_default" do
    value 262144
end
sysctl "net.core.rmem_max" do
    value 8388608
end
sysctl "net.core.wmem_max" do
    value 8388608
end
sysctl "net.core.netdev_max_backlog" do
    value 10000
end
sysctl "net.ipv4.tcp_rmem" do
    value "8192 87380 8388608"
end
sysctl "net.ipv4.tcp_wmem" do
    value "8192 65536 8388608"
end
sysctl "net.ipv4.udp_rmem_min" do
    value 16384
end
sysctl "net.ipv4.udp_wmem_min" do
    value 16384
end
sysctl "net.ipv4.tcp_mem" do
    value "8388608 12582912 16777216"
end
sysctl "net.ipv4.udp_mem" do
    value "8388608 12582912 16777216"
end
sysctl "vm.swappiness" do
    value 1
end
sysctl "vm.dirty_ratio" do
    value 50
end
sysctl "vm.pagecache" do
    value 90
end
sysctl "net.ipv4.icmp_echo_ignore_broadcasts" do
    value 0
end
