#
# Cookbook:: kubernete_deploy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe "::packages"

execute "Joining your nodes" do
	command "sudo kubeadm join --token 56fa9a.705a6001db6a6756 192.168.10.21"
	action :run
end
