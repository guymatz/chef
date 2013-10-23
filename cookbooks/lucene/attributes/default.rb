# Make sure you define a cluster_size in roles/WHATEVER_cluster.rb
# default[:cluster_size] = 5

# The "lucene" data bag "clusters" item defines keyspaces for the cluster named here:
default[:lucene][:cluster_name]      = node[:cluster_name] || "Test"

#
# Make a databag called 'lucene', with an element 'clusters'.
# Within that, define a hash named for your cluster (the setting right above).
#
# - keys_cached:                        specifies the number of keys per sstable whose
#   locations we keep in memory in "mostly LRU" order.  (JUST the key
#   locations, NOT any column values.) Specify a fraction (value less
#   than 1) or an absolute number of keys to cache.  Defaults to 200000
#   keys.
# - rows_cached:                        specifies the number of rows whose entire contents we
#   cache in memory. Do not use this on ColumnFamilies with large rows,
#   or ColumnFamilies with high write:read ratios. Specify a fraction
#   (value less than 1) or an absolute number of rows to cache.
#   Defaults to 0. (i.e. row caching is off by default)
# - comment:                            used to attach additional human-readable information about
#   the column family to its definition.
# - read_repair_chance:                 specifies the probability with which read
#   repairs should be invoked on non-quorum reads.  must be between 0
#   and 1. defaults to 1.0 (always read repair).
# - preload_row_cache:                  If true, will populate row cache on startup.
#   Defaults to false.
# - gc_grace_seconds:                   specifies the time to wait before garbage
#   collecting tombstones (deletion markers). defaults to 864000 (10
#   days). See http://wiki.apache.org/lucene/DistributedDeletes
#
default[:lucene][:keyspaces]         = {}

# Directories, hosts and ports        # =
default[:lucene][:home_dir]          = '/usr/local/share/lucene'
default[:lucene][:conf_dir]          = '/etc/lucene'
default[:lucene][:log_dir]           = '/var/log/lucene'
default[:lucene][:lib_dir]           = '/var/lib/lucene'
default[:lucene][:pid_dir]           = '/var/run/lucene'

default[:lucene][:data_root_mount]	= ["/data"]
default[:lucene][:data_device]	= ["/dev/sdb1"]
default[:lucene][:data_dirs]         = ["/data/db/lucene"]
default[:lucene][:commitlog_dir]     = "/var/lib/lucene/commitlog"
default[:lucene][:saved_caches_dir]  = "/var/lib/lucene/saved_caches"

default[:lucene][:user]              = 'lucene'
default[:lucene][:group]             = 'nogroup'
default[:users]['lucene'][:uid]      = 330
default[:users]['lucene'][:gid]      = 330

default[:lucene][:listen_addr]       = "localhost"
default[:lucene][:seeds]             = ["127.0.0.1"]
default[:lucene][:start_native_transport]	= "false"
default[:lucene][:native_transport_port]	= 9042
default[:lucene][:start_rpc]		= "true"
default[:lucene][:rpc_server_type]   = "sync"
default[:lucene][:rpc_addr]          = "localhost"
default[:lucene][:rpc_port]          = 9160
default[:lucene][:storage_port]      = 7000
default[:lucene][:ssl_storage_port]  = 7001
default[:lucene][:jmx_dash_port]     = 12345         # moved from default of 8080 (conflicts with hadoop)
default[:lucene][:mx4j_addr]  = "127.0.0.1"
default[:lucene][:mx4j_port]  = "8081"

#
# Install
#

# # install_from_release
# default[:pylucene][:version]           = "3.6.3"
# # install_from_release: tarball url
# default[:pylucene][:release_url]       = ":apache_mirror:/lucene/:version:/apache-lucene-:version:-bin.tar.gz"
# default[:lucene][:jna_release_url]	= "http://yum.ihr/files/jna-3.5.2.jar"

# install_from_release
default[:pylucene][:version]           = "3.6.2-1"
# install_from_release: tarball url
default[:pylucene][:release_url]       = "http://yum.ihr/files/pylucene-#{default[:pylucene][:version]}-src.tar.gz"
default[:lucene][:jna_release_url]  = "http://yum.ihr/files/jna-3.5.2.jar"

# Git install

# Git repo location
default[:lucene][:git_repo]          = 'git://git.apache.org/lucene.git'
# until ruby gem is updated, use cdd239dcf82ab52cb840e070fc01135efb512799
default[:lucene][:git_revision]      = 'cdd239dcf82ab52cb840e070fc01135efb512799' # 'HEAD'
# JNA deb location
default[:lucene][:jna_deb_amd64_url] = "http://debian.riptano.com/maverick/pool/libjna-java_3.2.7-0~nmu.2_amd64.deb"
# MX4J Version
default[:lucene][:mx4j_version]      = "3.0.2"
# MX4J location (at least as of Version 3.0.2)
default[:lucene][:mx4j_release_url]  = "http://downloads.sourceforge.net/project/mx4j/MX4J%20Binary/#{node[:lucene][:mx4j_version]}/mx4j-#{node[:lucene][:mx4j_version]}.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmx4j%2Ffiles%2F&ts=1303407638&use_mirror=iweb"

#
# Tunables - Partitioning
#

default[:lucene][:authenticator]     = "org.apache.lucene.auth.AllowAllAuthenticator"
default[:lucene][:authorizer]         = "org.apache.lucene.auth.AllowAllAuthorizer"
default[:lucene][:permissions_validity_in_ms] = 2000
default[:lucene][:partitioner]       = "org.apache.lucene.dht.Murmur3Partitioner"       # "org.apache.lucene.dht.OrderPreservingPartitioner"
default[:lucene][:endpoint_snitch]   = "org.apache.lucene.locator.SimpleSnitch"
default[:lucene][:hinted_handoff_enabled]       = "true"
default[:lucene][:max_hint_window_in_ms]        = 10800000
default[:lucene][:max_hints_delivery_threads]   = 2

#
# Tunables -- Memory, Disk and Performance
#

default[:lucene][:num_tokens]		   = 256
default[:lucene][:key_cache_size_in_mb]	   = ""
default[:lucene][:key_cache_save_period]	   = 14400
default[:lucene][:row_cache_size_in_mb]	   = 0
default[:lucene][:row_cache_save_period]	   = 0
default[:lucene][:row_cache_provider]	   = "SerializingCacheProvider"
default[:lucene][:disk_failure_policy]	   = "stop" 
default[:lucene][:populate_io_cache_on_flush]   = "false"
default[:lucene][:java_heap_size_min]           = "128M"        # consider setting equal to max_heap in production
default[:lucene][:java_heap_size_max]           = "1650M"
default[:lucene][:java_heap_size_eden]          = "1500M"
default[:lucene][:concurrent_reads]             = 32             # 2 per core
default[:lucene][:concurrent_writes]            = 32            # typical number of clients
default[:lucene][:memtable_flush_writers]       = 1             # see comment in lucene.yaml.erb
default[:lucene][:memtable_flush_queue_size]	   = 4
default[:lucene][:memtable_flush_after]         = 60
default[:lucene][:trickle_fsync]                = "false"
default[:lucene][:trickle_fsync_interval_in_kb] = 10240
default[:lucene][:sliced_buffer_size]           = 64            # size of column slices
default[:lucene][:thrift_framed_transport]      = 15            # default 15; fixes lucene-475, but make sure your client is happy (Set to nil for debugging)
default[:lucene][:thrift_max_message_length]    = 16
default[:lucene][:incremental_backups]          = false
default[:lucene][:snapshot_before_compaction]   = false
default[:lucene][:auto_snapshot]		   = true
default[:lucene][:memtable_throughput]          = 64
default[:lucene][:memtable_ops]                 = 0.3
default[:lucene][:column_index_size]            = 64
default[:lucene][:in_memory_compaction_limit]   = 64
default[:lucene][:multithreaded_compaction]     = "false"
default[:lucene][:compaction_throughput_mb_per_sec]	= 16
default[:lucene][:read_request_timeout_in_ms]   = 10000
default[:lucene][:range_request_timeout_in_ms]  = 10000
default[:lucene][:write_request_timeout_in_ms]  = 10000
default[:lucene][:truncate_request_timeout_in_ms]  = 60000
default[:lucene][:request_timeout_in_ms]	   = 10000
default[:lucene][:compaction_preheat_key_cache] = true
default[:lucene][:commitlog_rotation_threshold] = 128
default[:lucene][:commitlog_sync]               = "periodic"
default[:lucene][:commitlog_sync_period]        = 10000
default[:lucene][:commitlog_segment_size_in_mb] = 32
default[:lucene][:flush_largest_memtables_at]   = 0.75
default[:lucene][:reduce_cache_sizes_at]        = 0.85
default[:lucene][:reduce_cache_capacity_to]     = 0.6
default[:lucene][:rpc_keepalive]                = "false"
default[:lucene][:phi_convict_threshold]        = 8
default[:lucene][:cross_node_timeout]	   = "false"
default[:lucene][:streaming_socket_timeout_in_ms]	= 0
default[:lucene][:request_scheduler]            = 'org.apache.lucene.scheduler.NoScheduler'
default[:lucene][:throttle_limit]               = 80           # 2x (concurrent_reads + concurrent_writes)
default[:lucene][:request_scheduler_id]         = 'keyspace'

default[:lucene][:ulimits] = [ { 
                                   "type" => "soft",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 },
                                 { 
                                   "type" => "hard",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 },
                                 { 
                                   "type" => "soft",
                                   "item" => "memlock",
                                   "value" => "unlimited"
                                 },
                                 { 
                                   "type" => "hard",
                                   "item" => "memlock",
                                   "value" => "unlimited"
                                 },
				 {
				  "type" => "soft",
				  "item" => "as",
				  "value" => "unlimited"
				 },
                                 { 
                                   "type" => "hard",
                                   "item" => "as",
                                   "value" => "unlimited"
                                 }
				]
default[:lucene][:root_ulimits] = [ {
                                   "type" => "soft",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 },
                                 { 
                                   "type" => "hard",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 }
                               ]
