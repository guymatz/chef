
default[:hsflow][:packages] = %w{ hsflowd }

# things like ganglia, graphite, sflowtool, etc
default[:hsflow][:collectors] = ["10.5.33.16", "graphite.ihrint.com"]
