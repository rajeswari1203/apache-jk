#
# Cookbook Name:: learn_chef_httpd
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
tmp_path = Chef::Config[:file_cache_path]
package 'httpd'
package 'httpd-devel'

service 'httpd' do
  action [:enable, :start]
end
remote_file "#{tmp_path}/jk-connector.tar.gz" do
  source 'http://mirrors.estointernet.in/apache/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.46-src.tar.gz'
  action :create
end
bash 'Extract tomcat archive' do
  code <<-EOH
     
    tar -zxvf #{tmp_path}/jk-connector.tar.gz 
    cd /native
    ./configure --with-apxs=/usr/bin/apxs
    make
    make install
  EOH
end
 package 'gcc' do
 package_name 'gcc'
end
template "/etc/httpd/conf.d/modjk.conf" do
source 'modjk.conf.erb'
end
template "/etc/httpd/conf.d/workers.properties" do
 source "workers.properties.erb"
end
service 'httpd' do
  action :restart
end
