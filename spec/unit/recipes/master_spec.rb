#
# Cookbook:: kubernete_deploy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
require 'spec_helper'

describe 'include_recipe::packages' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge(described_recipe) }

  it 'includes the `packages` recipe' do
    expect(chef_run).to include_recipe('include_recipe::packages')
  end
end


describe 'multiple_actions::sequential' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611', log_level: :fatal).converge(described_recipe) }

  it 'executes kubeadm init' do
   expect(chef_run).to run_execute('kubeadm init --token 56fa9a.705a6001db6a6756')
  end

   it 'executes kubectl apply' do
   expect(chef_run).to run_execute('kubectl apply -f https://git.io/weave-kube')
  end
end





