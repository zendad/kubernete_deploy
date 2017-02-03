#
# Cookbook:: kubernete_deploy
# Recipe:: packeges
#
# Copyright:: 2017, The Authors, All Rights Reserved.yum_repository 'zenoss' do

# create yum repo and install the packages

require 'spec_helper'

describe 'kubernete_deploy::packages' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.2.1511', log_level: :fatal).converge(described_recipe) }
  
  it 'creates a yum_repository with create action' do
    expect(chef_run).to create_yum_repository('kubernetes')
  end

  it 'executes setenforce 0' do
   expect(chef_run).to run_execute('disable selinux - running').with(command:'setenforce 0')
  end

  it 'install docker-engine' do
   expect(chef_run).to upgrade_yum_package('docker-engine')
  end

   it 'install kubelet' do
   expect(chef_run).to upgrade_yum_package('kubelet')
  end

   it 'install kubeadm' do
   expect(chef_run).to upgrade_yum_package('kubeadm')
  end

   it 'install kubectl' do
   expect(chef_run).to upgrade_yum_package('kubectl')
  end

   it 'install kubernetes-cni' do
   expect(chef_run).to upgrade_yum_package('kubernetes-cni')
  end

  it 'executes both actions on docker' do
    expect(chef_run).to enable_service('docker')
    expect(chef_run).to start_service('docker')
  end

  it 'executes both actions on docker' do
    expect(chef_run).to enable_service('kubelet')
    expect(chef_run).to start_service('kubelet')
  end
end


