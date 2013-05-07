# Install the Gridcentric VMS collectors

include_recipe 'diamond::default'

collector_config "VMSDomsCollector"
collector_config "VMSFSCollector"
