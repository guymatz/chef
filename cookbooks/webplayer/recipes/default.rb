#
# Cookbook Name:: webplayer
# Recipe:: default
#
# Copyright 2013, iHeartRadio
# Jake Plimack <Jake.plimack@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

application "webplayer" do
	    path node[:webplayer][:deploy_path]
	    owner "nobody"
	    group "nogroup"
	    repository node[:webplayer][:repository]
	    revistion node[:webplayer][:rev]
	    migrate false

	    django do
		   requirements "requirements.txt"
		   debug true
		   settings_template "settings.py.erb"
	    end

	    gunicorn do
		     app_module :django
		     Chef::Log.info("Starting up Gunicorn on port 8080 for Basejump")
		     port 8080
	    end

end
