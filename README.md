# kubernete_deploy cookbook

kubernete_deploy cookbook to deploy Kubernetes cluster on RHEL/CentOS 7.x. using kubeadm

## Introduction

You should at least give below information:

* kubeadm master ip address
* kubeadm node ip address list


## Quick start

Suppose your kubeadm nodes are like below (You can make the nodes' hostname resolvable):

```
# Role         Hostname       IP Address 
# Master       kuber-master  10.208.104.141 
# Node         kuber-node1   10.208.104.142 
# Node         kuber-node2   10.208.104.143 
# Node         kuber-node3   10.208.104.144 
```
Upload the kubernete_deploy role/cookbook to Chef server:

```
# knife role from file roles/*.json
# knife cookbook upload kubernete_deploy
```

Start boostraping your nodes:

```
# knife bootstrap 10.208.104.141 -E kubernete_deploy -r 'role[kubernetes-master]'
# knife bootstrap 10.208.104.142 -E kubernete_deploy -r 'role[kubernetes-node]'
# knife bootstrap 10.208.104.143 -E kubernete_deploy -r 'role[kubernetes-node]'
# knife bootstrap 10.208.104.144 -E kubernete_deploy -r 'role[kubernetes-node]'
```

## Roles
* kubernetes-master Install and configure Kubernetes master node.
* kubernetes-node Install and configure Kubernetes nodes.

## Recipes
* kubernete_deploy::master  Install and configure Kubernetes Master .
* kubernete_deploy::node  Install and configure Kubernetes node.
* kubernete_deploy::packages  has all the packages to be installed on master and node

##Cookbook Tests.
run `chef exec rspec` or `chef exec rspec` in the cookbook root to see results of unit tests for each recipe

you can also test the cookbook using the `.kitchen.yml` configuration file in the cookbook root directory. Virtualbox is a prerequsite for this test.
whilst in the cookbook run the following commands:
`kitchen create` this will create the CentOS instance for tests
Then run `kitchen converge` to apply the cookbook to the CentOS virtual machine.
Test Kitchen runs chef-client on the instance. When the chef-client run completes successfully, Test Kitchen exits with exit code 0.
Run the following to check the exit code `echo $?`




