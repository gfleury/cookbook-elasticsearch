node.default[:elasticsearch][:plugin][:mandatory] = Array(node[:elasticsearch][:plugin][:mandatory] | ['cloud-aws'])

service "elasticsearch" do
   supports :status => true, :restart => true
   action [ :enable ]
end

conf_path = "/usr/local/etc/elasticsearch/elasticsearch.yml"

script 'inject_conf' do
  interpreter "bash"
  code <<-EOH
    echo "plugin.mandatory: cloud-aws" >> #{conf_path}
    echo "discovery.type: ec2" >> #{conf_path}
    echo "discovery.zen.minimum_master_nodes: 1" >> #{conf_path}
    echo "discovery.zen.ping.multicast.enabled: true" >> #{conf_path}
    echo "cloud.node.auto_attributes: true" >> #{conf_path}
    echo "cloud.aws.access_key: #{node[:awsc][:aws_key]}" >> #{conf_path}
    echo "cloud.aws.secret_key: #{node[:awsc][:aws_secret]}" >> #{conf_path}
    echo "discovery.ec2.groups: #{node[:awsc][:aws_sg]}" >> #{conf_path}
    echo "discovery.ec2.any_group: false" >> #{conf_path}
    echo "script.groovy.sandbox.enabled: true" >> #{conf_path}
    sed -i '/discovery.zen.ping.multicast.enabled: true/d' #{conf_path}
    sed -i '/discovery.zen.minimum_master_nodes: 1/d' #{conf_path}
    EOH
end

install_plugin "elasticsearch/elasticsearch-cloud-aws/#{node.elasticsearch['plugins']['elasticsearch/elasticsearch-cloud-aws']['version']}"


