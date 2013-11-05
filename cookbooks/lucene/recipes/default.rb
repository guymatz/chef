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
  %w{ python27 python27-devel java-1.7.0-openjdk-devel emacs gcc ant apache-ivy glibc-devel freetds freetds-devel unixODBC-devel mercurial }.each do |pkg|
    package pkg do
      action :install
    end
  end

  # We need this link in place for JCC to install .  Hack!
  link  "/usr/lib/jvm/java-7-openjdk-amd64" do
    to "/usr/lib/jvm/java-openjdk"
  end

  # TODO: Creates python27-compatible RPMs of the PIPs below and get rid of virtual env
  python_virtualenv "/data/apps/names/venv" do
    interpreter 'python27'
    owner 'root'
    group 'root'
    action :create
  end

  # No idea why this has to work as an array
  odbc_pip = [ 'pyodbc', ' -e hg+https://code.google.com/p/py-editdist/#egg=editdist' ]
  odbc_pip.each do |p|
    python_pip p do
      virtualenv '/data/apps/names/venv'
      action :install
    end
  end

  cookbook_file "/etc/odbcinst.ini" do
    source "odbcinst.ini"
    mode 0755
    action :create
  end
 
  python_pip "JCC" do 
    virtualenv "/data/apps/names/venv"
    version "2.15"
    action :install
  end
 
  #  Needs freetds-devel to build (See RPMs above)
  python_pip "pymssql" do 
    virtualenv "/data/apps/names/venv"
    action :install
  end


  # Builds lucene/pylucene from source
  include_recipe "lucene::install_from_release"

  tag(deployed_tag)
else
  log "NOT executing lucene due to tag: #{deployed_tag}" do
    level :info
  end
end
