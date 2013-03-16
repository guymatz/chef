

# Deployment Settings
default[:webplayer][:repo] = "git@github.com:iheartradio/iheart-chef.git"
default[:webplater][:rev] = "deploy"
default[:webplayer][:deploy_path] = "/data/www/webplayer"

default[:webplayer][:packages] = %w{ }
