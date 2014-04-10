#
# Cookbook Name:: radioedit
# Recipe:: binstore-backup
#
#
#
# All rights reserved - Do Not Redistribute
#
#
# authors: gpatmore
#
# ########################################

default[:radioedit][:binstore] = {
  :local_dir    => '/data/exports/files.ihrdev.com/radioedit-stash/radioedit',
  :remote_dir   => '/data/exports/dr_backups/radioedit',
  :remote_host  => 'iad-backup101.ihr'
};