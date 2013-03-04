
default[:attivio][:aie_install_path] = "/data/apps/attivio"
default[:attivio][:install_path] = "/data/apps/attivio31"
default[:attivio][:user] = "attivio"
default[:attivio][:group] = "attivio"

default[:attivio][:repo] = "git@github.com:iheartradio/attivio.git"
default[:attivio][:rev] = "deploy"

default[:attivio][:packages] = %w{ expect }
