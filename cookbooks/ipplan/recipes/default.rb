#
# Cookbook Name:: ipplan
# Recipe:: default
#
# Copyright 2012, Clearchannel Communications
# Written by Jake Plimack <jakeplimack@clearchannel.com>
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ipplan::webserver"
include_recipe "ipplan::scripts"
