# Encoding: utf-8
#
# Cookbook Name:: elasticsearch
# Recipe:: default
#

include_recipe 'chef-sugar'
include_recipe 'curl'

# see README.md and test/fixtures/cookbooks for more examples!
#elasticsearch_user 'elasticsearch'
#elasticsearch_install 'elasticsearch'
#elasticsearch_configure 'elasticsearch'
#elasticsearch_service 'elasticsearch'

elasticsearch_plugin 'elasticsearch/elasticsearch-cloud-aws'



# by default, no plugins
