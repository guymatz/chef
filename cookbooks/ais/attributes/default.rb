# Performance sysctl settings

default['ais']['sysctl_settings'] = {
                                     'fs.file-max' => '1048576',
                                     'net.core.netdev_max_backlog' => '400000',
                                     'net.core.optmem_max' => '10000000',
                                     'net.core.rmem_default' => '10000000',
                                     'net.core.rmem_max' => '10000000',
                                     'net.core.somaxconn' => '65535',
                                     'net.core.wmem_default' => '10000000',
                                     'net.core.wmem_max' => '10000000',
                                     'net.ipv4.conf.all.rp_filter' => '2',
                                     'net.ipv4.conf.default.rp_filter' => '2',
                                     'net.ipv4.ip_local_port_range' => '1024 65535',
                                     'net.ipv4.tcp_congestion_control' => 'cubic',
                                     'net.ipv4.tcp_ecn' => '0',
                                     'net.ipv4.tcp_max_syn_backlog' => '12000',
                                     'net.ipv4.tcp_max_tw_buckets' => '2000000',
                                     'net.ipv4.tcp_mem' => '30000000 30000000 30000000',
                                     'net.ipv4.tcp_rmem' => '30000000 30000000 30000000',
                                     'net.ipv4.tcp_sack' => '1',
                                     'net.ipv4.tcp_syncookies' => '0',
                                     'net.ipv4.tcp_timestamps' => '1',
                                     'net.ipv4.tcp_wmem' => '30000000 30000000 30000000',
                                     'net.ipv4.tcp_tw_reuse' => '1'
                                    }
