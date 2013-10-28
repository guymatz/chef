#
# Cookbook Name:: elasticsearchnew
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

deployed_tag = 'lucene-deployed'

unless tagged?(deployed_tag)
  %w{ ark python::pip }.each do |cb|
    include_recipe cb
  end
  
  %w{ }.each do |der|
    directory "#{der}" do
    end
  end

  # mercurial is a kludge/requirement for for editdist install below
  %w{ python27 python27-devel java-1.7.0-openjdk-devel emacs gcc ant apache-ivy glibc-devel freetds unixODBC-devel mercurial }.each do |pkg|
    package pkg do
      action :install
    end
  end

  # We need this link in place for JCC to install .  Hack!
  link  "/usr/lib/jvm/java-7-openjdk-amd64" do
    to "/usr/lib/jvm/java-openjdk"
  end

  python_virtualenv "/data/apps/names/venv" do
    interpreter 'python27'
    owner 'root'
    group 'root'
    action :create
  end

  pips = [ 'pyodbc', ' -e hg+https://code.google.com/p/py-editdist/#egg=editdist' ]

  pips.each do |p|
    python_pip p do
      virtualenv '/data/apps/names/venv'
      action :install
    end
  end
 
  python_pip "JCC" do 
    virtualenv "/data/apps/names/venv"
    version "2.15"
    action :install
  end

  include_recipe "lucene::install_from_release"

  # service "elasticsearch" do
  #   supports :start => true, :stop =>true, :restart => true
  #   action :enable
  # end
  
  tag(deployed_tag)
else
  log "NOT executing lucene due to tag: #{deployed_tag}" do
    level :info
  end
end
