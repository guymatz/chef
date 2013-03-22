#
# Cookbook Name:: sendmail
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'sendmail'

package 'sendmail-cf'

service 'postfix' do
	action [ :disable,:stop ]
end
 
service 'sendmail' do
        action [ :enable,:start ]
end
