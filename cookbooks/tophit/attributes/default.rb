

default[:tophit][:repo] = "git@github.com:iheartradio/datasearch.git"
default[:tophit][:rev] = "deploy"

default[:tophit][:deploy_path] = "/data/apps/tophit"

default[:tophit][:packages] = %w{ python27 python27-libs python27-devel python27-test python27-tools graphviz-devel libevent-devel }

default[:tophit][:init_style] = "heartbeat" # heartbeat or init
