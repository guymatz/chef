#
# Cookbook Name:: elasticsearchnew
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
unless tagged?('lucene-deployed')
  %w{ ark python::pip }.each do |cb|
    include_recipe cb
  end
  
  %w{ }.each do |der|
    directory "#{der}" do
    end
  end
  
  %w{ python27 python27-devel python27-libs emacs gcc ant apache-ivy glibc-devel freetds pyodbc python-editdist JCC}.each do |pkg|
    package pkg do
      action :install
    end
  end
  
##@#  python_pip "JCC" do
##@#      action :install
##@#      version "2.16"
##@#  end

  %w{ distribute }.each do |pkg|
    python_pip pkg do
      action :install
    end
  end
  

  include_recipe "lucene::install_from_release"

  # service "elasticsearch" do
  #   supports :start => true, :stop =>true, :restart => true
  #   action :enable
  # end
  
  tag('lucene-deployed')
end
