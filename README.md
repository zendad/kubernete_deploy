# kubernete_deploy cookbook

kubernete_deploy cookbook to deploy Kubernetes cluster on RHEL/CentOS 7.x. using kubeadm

## Introduction

You should at least give below information:

* kubeadm master ip address
* kubeadm node ip address list


## Quick start

Suppose your kubeadm nodes are like below (You can make the nodes' hostname resolvable):

| Role        | Hostname      | IP Address 
|-------------|-------------------------------
| Master      | kuber-master  |10.208.104.141 
| Node        | kuber-node1   |10.208.104.142 
| Node        | kuber-node2   |10.208.104.143 
| Node        | kuber-node3   |10.208.104.144 

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

##Units Tests.
run `chef exec rspec` to see results of unit tests

