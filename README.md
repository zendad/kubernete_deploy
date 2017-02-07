# kubernete_deploy cookbook

kubernete_deploy cookbook to deploy Kubernetes cluster on RHEL/CentOS 7.x. using kubeadm

## Introduction

You should at least give below information:

* kubeadm master ip address
* kubeadm node ip address list


## Quick start

Suppose your kubeadm nodes are like below (You can make the nodes' hostname resolvable):

```
# Role         Hostname       		IP Address 
# Master       kuber-master.dereck.com  192.168.10.21 
# Node         kuber-node1.dereck.com   192.168.10.22 
# Node         kuber-node2.dereck.com   192.168.10.23
# Node         kuber-node3.dereck.com   192.168.10.24 
```
Upload the kubernete_deploy role/cookbook to Chef server:

```
# knife role from file roles/*.json
# knife cookbook upload kubernete_deploy
```

Start boostraping your nodes:

```
# knife bootstrap 192.168.10.21 -E kubernete_deploy -r 'role[kubernetes-master]'
# knife bootstrap 192.168.10.22 -E kubernete_deploy -r 'role[kubernetes-node]'
# knife bootstrap 192.168.10.23 -E kubernete_deploy -r 'role[kubernetes-node]'
# knife bootstrap 192.168.10.24 -E kubernete_deploy -r 'role[kubernetes-node]'
```

## Roles
* kubernetes-master Install and configure Kubernetes master node.
* kubernetes-node Install and configure Kubernetes nodes.

## Recipes
* kubernete_deploy::master  Install and configure Kubernetes Master .
* kubernete_deploy::node  Install and configure Kubernetes node.
* kubernete_deploy::packages  has all the packages to be installed on master and node

##Cookbook Tests
run `chef exec rspec` in the cookbook root to see results of unit tests for each recipe. Unit tests are in spec/unit/recipes/ of the cookbook directory.

```
 kubernete_deploy]# chef exec rspec 
WARNING: you must specify a platform and platform_version to your ChefSpec Runner and/or Fauxhai constructor, in the future omitting these will become a hard error
...............

Finished in 13.99 seconds (files took 1.6 seconds to load)
15 examples, 0 failures

```

you can also test the cookbook using the `.kitchen.yml` configuration file in the cookbook root directory. Virtualbox is a prerequsite for this test.
whilst in the cookbook root run the following commands:
`kitchen create` this will create the CentOS instance for tests. Provided its successful, below should be the result:
```
kubernete_deploy]# kitchen create
-----> Starting Kitchen (v1.14.2)
-----> Creating <kuber-master-centos-73>...
       Ignoring eventmachine-1.0.9.1 because its extensions are not built.  Try: gem pristine eventmachine --version 1.0.9.1
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'bento/centos-7.3'...
==> default: Matching MAC address for NAT networking...
       ==> default: Checking if box 'bento/centos-7.3' is up to date...
       ==> default: Setting the name of the VM: kitchen-kubernete_deploy-kuber-master-centos-73_default_1486461901237_36447
       ==> default: Fixed port collision for 22 => 2222. Now on port 2201.
       ==> default: Clearing any previously set network interfaces...
       ==> default: Preparing network interfaces based on configuration...
           default: Adapter 1: nat
       ==> default: Forwarding ports...
           default: 22 (guest) => 2201 (host) (adapter 1)
       ==> default: Booting VM...
       ==> default: Waiting for machine to boot. This may take a few minutes...
           default: SSH address: 127.0.0.1:2201
           default: SSH username: vagrant
           default: SSH auth method: private key
           default: Warning: Remote connection disconnect. Retrying...
           default: 
           default: Vagrant insecure key detected. Vagrant will automatically replace
           default: this with a newly generated keypair for better security.
           default: 
           default: Inserting generated public key within guest...
           default: Removing insecure key from the guest if it's present...
           default: Key inserted! Disconnecting and reconnecting using new SSH key...
       ==> default: Machine booted and ready!
       ==> default: Checking for guest additions in VM...
       ==> default: Setting hostname...
       ==> default: Automatic installation for Landrush IP not enabled
       ==> default: Mounting shared folders...
           default: /tmp/omnibus/cache => /root/.kitchen/cache
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [SSH] Established
       Vagrant instance <kuber-master-centos-73> created.
       Finished creating <kuber-master-centos-73> (1m0.37s).
-----> Creating <kuber-node-centos-73>...
       Ignoring eventmachine-1.0.9.1 because its extensions are not built.  Try: gem pristine eventmachine --version 1.0.9.1
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'bento/centos-7.3'...
==> default: Matching MAC address for NAT networking...
       ==> default: Checking if box 'bento/centos-7.3' is up to date...
       ==> default: Setting the name of the VM: kitchen-kubernete_deploy-kuber-node-centos-73_default_1486461960710_33631
       ==> default: Fixed port collision for 22 => 2222. Now on port 2202.
       ==> default: Clearing any previously set network interfaces...
       ==> default: Preparing network interfaces based on configuration...
           default: Adapter 1: nat
       ==> default: Forwarding ports...
           default: 22 (guest) => 2202 (host) (adapter 1)
       ==> default: Booting VM...
       ==> default: Waiting for machine to boot. This may take a few minutes...
           default: SSH address: 127.0.0.1:2202
           default: SSH username: vagrant
           default: SSH auth method: private key
           default: Warning: Remote connection disconnect. Retrying...
           default: 
           default: Vagrant insecure key detected. Vagrant will automatically replace
           default: this with a newly generated keypair for better security.
           default: 
           default: Inserting generated public key within guest...
           default: Removing insecure key from the guest if it's present...
           default: Key inserted! Disconnecting and reconnecting using new SSH key...
       ==> default: Machine booted and ready!
       ==> default: Checking for guest additions in VM...
       ==> default: Setting hostname...
       ==> default: Automatic installation for Landrush IP not enabled
       ==> default: Mounting shared folders...
           default: /tmp/omnibus/cache => /root/.kitchen/cache
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [SSH] Established
       Vagrant instance <kuber-node-centos-73> created.
       Finished creating <kuber-node-centos-73> (0m59.00s).
-----> Kitchen is finished. (2m0.10s)
```

Results of the above command will result in the creation of two test instances.

```
 kubernete_deploy]# kitchen list
kuber-master-centos-73  Vagrant  ChefZero     Inspec    Ssh        Created      <None>
kuber-node-centos-73    Vagrant  ChefZero     Inspec    Ssh        Created      <None>

```
Then run `kitchen converge` to apply the cookbook to the CentOS virtual machine. No putting the results of `kitchen converge` here quite long.
Test Kitchen runs chef-client on the instance. When the chef-client run completes successfully, Test Kitchen exits with exit code 0.
Run the following to check the exit code `echo $?` and the results of ` kitchen list` should show as below:
```

```
 kubernete_deploy]# kitchen list
Instance           Driver   Provisioner  Verifier  Transport  Last Action  Last Error
kuber-master-centos-73   Vagrant  ChefZero     Inspec    Ssh        Converged    <None>
kuber-node-centos-73    Vagrant  ChefZero     Inspec    Ssh        Converged    <None>
```




