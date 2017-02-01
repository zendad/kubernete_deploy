#
# Cookbook:: kubernete_deploy
# Recipe:: packeges
#
# Copyright:: 2017, The Authors, All Rights Reserved.yum_repository 'zenoss' do

# create yum repo and install the packages

yum_repository 'kubernetes' do
	description "kubernetesrepo"
	 baseurl "http://yum.kubernetes.io/repos/kubernetes-el7-x86_64"
	 gpgkey "https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg"
       enabled true
       repo_gpgcheck true
       gpgcheck true
       clean_metadata false
       action :create
end

#use the latest docker repo
remote_file '/etc/yum.repos.d/docker.repo' do
  source 'https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

#set selinux to perrmissive in session
execute "disable selinux - running" do
      command "setenforce 0"
      action :run
end

# install packages
package ['docker-engine', 'kubelet', 'kubeadm', 'kubectl','kubernetes-cni'] do
	action:upgrade
end

#enable and start services
service "kubelet" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

service "docker" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

