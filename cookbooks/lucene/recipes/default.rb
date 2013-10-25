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
  
  %w{ python27 python27-devel python27-libs emacs gcc ant apache-ivy glibc-devel freetds}.each do |pkg|
    package pkg do
      action :install
    end
  end
  
  # We need this link in place for JCC to install .  Hack!
  link "/usr/lib/jvm/java-openjdk" do
    to "/usr/lib/jvm/java-7-openjdk-amd64"
  end

  python_virtualenv "/data/apps/names/shared" do
    interpreter "python27"
    owner "root"
    group "root"
    action :create
  end
  
  %w{distribute pyodbc python-editdist JCC}.each { |p| 
    python_pip p do 
      virtualenv "/data/apps/names/shared"
      action :install
    end
  }

##@#  include_recipe "lucene::install_from_release"

  # service "elasticsearch" do
  #   supports :start => true, :stop =>true, :restart => true
  #   action :enable
  # end
  
##@#  tag('lucene-deployed')
end
