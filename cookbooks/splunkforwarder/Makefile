# Makefile for the splunkforwarder Cookbook.
#
# Source:: https://github.com/ampledata/cookbook-splunkfowarder
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0.
#


TMP_TEMPLATE = 'tmp.splunkforwarder.XXXXXXXXXX'

GIT_TAG := $(shell git describe --abbrev=0 --tags)
export CB_TMP := $(shell mktemp -d $(TMP_TEMPLATE))

SF_TMP = $(CB_TMP)/splunkforwarder


clean:
	rm -rf *.egg* build dist *.pyc *.pyo cover doctest_pypi.cfg nosetests.xml \
		pylint.log *.egg output.xml flake8.log output.xml */*.pyc .coverage core \
		nohup.out splunkforwarder*.tar.gz tmp

env:
	ruby -e "puts ENV['CB_TMP']"

sync_cookbook: clean
	rsync -a --exclude-from=.tar_exclude . $(SF_TMP)

publish: sync_cookbook
	knife cookbook site share splunkforwarder 'Monitoring & Trending' -o $(CB_TMP) -c knife.rb -VV

build_tarball: sync_cookbook
	knife cookbook metadata splunkforwarder -o $(CB_TMP) -c knife.rb
	cd $(CB_TMP); tar -zcpf ../splunkforwarder-$(GIT_TAG).tar.gz splunkforwarder

vagrant: sync_cookbook vagrant_reload

vagrant_up:
	vagrant up

vagrant_reload:
	vagrant reload

vagrant_destroy:
	vagrant destroy -f

nuke: vagrant_destroy sync_cookbook vagrant_up
