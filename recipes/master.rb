#
# Cookbook:: kubernete_deploy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe "::packages"

execute "initiate kubeadm master - get token" do
	command "sudo kubeadm init --token 56fa9a.705a6001db6a6756"
	action :run
end

execute "pod network install" do
	command "sudo kubectl apply -f https://git.io/weave-kube"
	action :run
end
