#
# Cookbook:: kubernete_deploy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
require 'spec_helper'

describe 'kubernete_deploy::node' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511').converge(described_recipe) }

  it 'includes the `packages` recipe' do
    expect(chef_run).to include_recipe('kubernete_deploy::packages')
  end
end


describe 'kubernete_deploy::node' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511', log_level: :fatal).converge(described_recipe) }

  it 'executes kubeadm join' do
   expect(chef_run).to run_execute('Joining your nodes').with(command:'sudo kubeadm join --token 56fa9a.705a6001db6a6756 10.208.104.141')
  end
end

