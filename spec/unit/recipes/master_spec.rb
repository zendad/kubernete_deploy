#
# Cookbook:: kubernete_deploy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
require 'spec_helper'

describe 'kubernete_deploy::master' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511').converge(described_recipe) }

  it 'includes the `packages` recipe' do
    expect(chef_run).to include_recipe('kubernete_deploy::packages')
  end
end


describe 'kubernete_deploy::master' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511', log_level: :fatal).converge(described_recipe) }

  it 'executes kubeadm init' do
   expect(chef_run).to run_execute('initiate kubeadm master - get token').with(command:'sudo kubeadm init --token 56fa9a.705a6001db6a6756')
  end

   it 'executes kubectl apply' do
   expect(chef_run).to run_execute('pod network install').with(command:'sudo kubectl apply -f https://git.io/weave-kube')
  end
end





