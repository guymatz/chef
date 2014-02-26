#
# Cookbook Name:: batch_jobs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

include 'users::ihr-deployer'

if not tagged?("batch_job_deployed") do
  bash "Checkout batch jobs"
