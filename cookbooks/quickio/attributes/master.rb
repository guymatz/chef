if node[:roles].include?('quickio-master')
	default[:quickio][:cluster][:is_server] = true
	default[:quickio][:cluster][:balance_cooldown] = 120
	default[:quickio][:cluster][:balance_interval] = 120
	default[:quickio][:cluster][:balance_min_clients] = 5000
	default[:quickio][:cluster][:balance_threshold] = 20

	default[:quickio][:ihrnowplaying][:is_server] = true
end
