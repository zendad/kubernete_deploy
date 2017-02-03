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
-----> Creating <master-centos-73>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'bento/centos-7.3'...
==> default: Matching MAC address for NAT networking...
       ==> default: Checking if box 'bento/centos-7.3' is up to date...
       ==> default: Setting the name of the VM: kitchen-kubernete_deploy-master-centos-73_default_1486105907761_56045
       ==> default: Fixed port collision for 22 => 2222. Now on port 2201.
       ==> default: Clearing any previously set network interfaces...
       ==> default: Preparing network interfaces based on configuration...
           default: Adapter 1: nat
           default: Adapter 2: hostonly
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
       ==> default: Configuring and enabling network interfaces...
       ==> default: Mounting shared folders...
           default: /tmp/omnibus/cache => /root/.kitchen/cache
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [SSH] Established
       Vagrant instance <master-centos-73> created.
       Finished creating <master-centos-73> (1m5.67s).
-----> Creating <node-centos-73>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'bento/centos-7.3'...
==> default: Matching MAC address for NAT networking...
       ==> default: Checking if box 'bento/centos-7.3' is up to date...
       ==> default: Setting the name of the VM: kitchen-kubernete_deploy-node-centos-73_default_1486105969233_16140
       ==> default: Fixed port collision for 22 => 2222. Now on port 2202.
       ==> default: Clearing any previously set network interfaces...
       ==> default: Preparing network interfaces based on configuration...
           default: Adapter 1: nat
           default: Adapter 2: hostonly
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
       ==> default: Configuring and enabling network interfaces...
       ==> default: Mounting shared folders...
           default: /tmp/omnibus/cache => /root/.kitchen/cache
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [SSH] Established
       Vagrant instance <node-centos-73> created.
       Finished creating <node-centos-73> (1m3.09s).
-----> Kitchen is finished. (2m9.56s)
```

Results of the above command will result in the creation of two test instances.

```
 kubernete_deploy]# kitchen list
Instance          Driver   Provisioner  Verifier  Transport  Last Action  Last Error
master-centos-73  Vagrant  ChefZero     Inspec    Ssh        Created      <None>
node-centos-73    Vagrant  ChefZero     Inspec    Ssh        Created      <None>
```
Then run `kitchen converge` to apply the cookbook to the CentOS virtual machine. No putting the results of `kitchen converge` here quite long.
Test Kitchen runs chef-client on the instance. When the chef-client run completes successfully, Test Kitchen exits with exit code 0.
Run the following to check the exit code `echo $?` and the results of ` kitchen list` should show as below:
```
kubernete_deploy]# kitchen converge
-----> Starting Kitchen (v1.14.2)
-----> Converging <master-centos-73>...
       Preparing files for transfer
       Preparing dna.json
       Resolving cookbook dependencies with Berkshelf 5.2.0...
       Removing non-cookbook files before transfer
       Preparing roles
       Preparing validation.pem
       Preparing client.rb
-----> Installing Chef Omnibus (install only if missing)
       Downloading https://omnitruck.chef.io/install.sh to file /tmp/install.sh
       Trying wget...
       Download complete.
       el 7 x86_64
       Getting information for chef stable  for el...
       downloading https://omnitruck.chef.io/stable/chef/metadata?v=&p=el&pv=7&m=x86_64
         to file /tmp/install.sh.3964/metadata.txt
       trying wget...
       trying curl...
       sha1	59d78114aa5e13cbb56e8ddc2eb423260e197683
       sha256	d535392f6f2aa236c6ffebd0e1f3c1a349a1a9294252a22b37b8d2aee9581f04
       url	https://packages.chef.io/files/stable/chef/12.18.31/el/7/chef-12.18.31-1.el7.x86_64.rpm
       version	12.18.31
       downloaded metadata file looks valid...
       /tmp/omnibus/cache/chef-12.18.31-1.el7.x86_64.rpm already exists, verifiying checksum...
       Comparing checksum with sha256sum...
       checksum compare succeeded, using existing file!
       
       WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
       
       You are installing an omnibus package without a version pin.  If you are installing
       on production servers via an automated process this is DANGEROUS and you will
       be upgraded without warning on new releases, even to new major releases.
       Letting the version float is only appropriate in desktop, test, development or
       CI/CD environments.
       
       WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
       
       Installing chef 
       installing with rpm...
       warning: /tmp/omnibus/cache/chef-12.18.31-1.el7.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 83ef826a: NOKEY
       Preparing...                          ################################# [100%]
       Updating / installing...
          1:chef-12.18.31-1.el7              ################################# [100%]
       Thank you for installing Chef!
       Transferring files to <master-centos-73>
       Starting Chef Client, version 12.18.31
       Creating a new client identity for master-centos-73 using the validator key.
       resolving cookbooks for run list: ["kubernete_deploy::master"]
       Synchronizing Cookbooks:
         - kubernete_deploy (0.1.0)
       Installing Cookbook Gems:
       Compiling Cookbooks...
       Converging 12 resources
       Recipe: kubernete_deploy::packages
         * yum_repository[kubernetes] action create
           * template[/etc/yum.repos.d/kubernetes.repo] action create
             - create new file /etc/yum.repos.d/kubernetes.repo
             - update content in file /etc/yum.repos.d/kubernetes.repo from none to f770eb
             --- /etc/yum.repos.d/kubernetes.repo	2017-02-03 12:00:41.787113368 +0000
             +++ /etc/yum.repos.d/.chef-kubernetes20170203-4101-3u3ema.repo	2017-02-03 12:00:41.787113368 +0000
             @@ -1 +1,13 @@
             +# This file was generated by Chef
             +# Do NOT modify this file by hand.
             +
             +[kubernetes]
             +name=kubernetesrepo
             +baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
             +enabled=1
             +fastestmirror_enabled=0
             +gpgcheck=1
             +gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
             +       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
             +repo_gpgcheck=1
             - change mode from '' to '0644'
             - restore selinux security context
           * execute[yum-makecache-kubernetes] action run
             - execute yum -q -y makecache --disablerepo=* --enablerepo=kubernetes
           * ruby_block[yum-cache-reload-kubernetes] action create
             - execute the ruby block yum-cache-reload-kubernetes
           * execute[yum clean metadata kubernetes] action nothing (skipped due to action :nothing)
           * execute[yum-makecache-kubernetes] action nothing (skipped due to action :nothing)
           * ruby_block[yum-cache-reload-kubernetes] action nothing (skipped due to action :nothing)
         
         * remote_file[/etc/yum.repos.d/docker.repo] action create
           - create new file /etc/yum.repos.d/docker.repo
           - update content in file /etc/yum.repos.d/docker.repo from none to 97f61c
           --- /etc/yum.repos.d/docker.repo	2017-02-03 12:00:53.130727262 +0000
           +++ /tmp/chef-rest20170203-4101-1ngkqz9	2017-02-03 12:00:53.129727208 +0000
           @@ -1 +1,28 @@
           +[docker-main]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/main/centos/7/
           +enabled=1
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           +
           +[docker-testing]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/testing/centos/$releasever/
           +enabled=0
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           +
           +[docker-beta]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/beta/centos/7/
           +enabled=0
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           +
           +[docker-nightly]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/nightly/centos/7/
           +enabled=0
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           - change mode from '' to '0644'
           - change owner from '' to 'root'
           - change group from '' to 'root'
           - restore selinux security context
         * execute[disable selinux - running] action run
           - execute setenforce 0
         * yum_package[docker-engine] action upgrade
           - upgrade package docker-engine from uninstalled to 1.13.0-1.el7.centos
         * yum_package[kubelet] action upgrade
           - upgrade package kubelet from uninstalled to 1.5.1-0
         * yum_package[kubeadm] action upgrade
           - upgrade package kubeadm from uninstalled to 1.6.0-0.alpha.0.2074.a092d8e0f95f52
         * yum_package[kubectl] action upgrade (up to date)
         * yum_package[kubernetes-cni] action upgrade (up to date)
         * service[kubelet] action enable
           - enable service service[kubelet]
         * service[kubelet] action start
           - start service service[kubelet]
         * service[docker] action enable
           - enable service service[docker]
         * service[docker] action start
           - start service service[docker]
       Recipe: kubernete_deploy::master
         * execute[initiate kubeadm master - get token] action run
           - execute sudo kubeadm init --token 56fa9a.705a6001db6a6756
         * execute[pod network install] action run
           - execute sudo kubectl apply -f https://git.io/weave-kube
       
       Running handlers:
       Running handlers complete
       Chef Client finished, 15/20 resources updated in 19 minutes 05 seconds
       Finished converging <master-centos-73> (19m41.02s).
-----> Converging <node-centos-73>...
       Preparing files for transfer
       Preparing dna.json
       Resolving cookbook dependencies with Berkshelf 5.2.0...
       Removing non-cookbook files before transfer
       Preparing roles
       Preparing validation.pem
       Preparing client.rb
-----> Installing Chef Omnibus (install only if missing)
       Downloading https://omnitruck.chef.io/install.sh to file /tmp/install.sh
       Trying wget...
       Download complete.
       el 7 x86_64
       Getting information for chef stable  for el...
       downloading https://omnitruck.chef.io/stable/chef/metadata?v=&p=el&pv=7&m=x86_64
         to file /tmp/install.sh.3982/metadata.txt
       trying wget...
       sha1	59d78114aa5e13cbb56e8ddc2eb423260e197683
       sha256	d535392f6f2aa236c6ffebd0e1f3c1a349a1a9294252a22b37b8d2aee9581f04
       url	https://packages.chef.io/files/stable/chef/12.18.31/el/7/chef-12.18.31-1.el7.x86_64.rpm
       version	12.18.31
       downloaded metadata file looks valid...
       /tmp/omnibus/cache/chef-12.18.31-1.el7.x86_64.rpm already exists, verifiying checksum...
       Comparing checksum with sha256sum...
       checksum compare succeeded, using existing file!
       
       WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
       
       You are installing an omnibus package without a version pin.  If you are installing
       on production servers via an automated process this is DANGEROUS and you will
       be upgraded without warning on new releases, even to new major releases.
       Letting the version float is only appropriate in desktop, test, development or
       CI/CD environments.
       
       WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
       
       Installing chef 
       installing with rpm...
       warning: /tmp/omnibus/cache/chef-12.18.31-1.el7.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 83ef826a: NOKEY
       Preparing...                          ################################# [100%]
       Updating / installing...
          1:chef-12.18.31-1.el7              ################################# [100%]
       Thank you for installing Chef!
       Transferring files to <node-centos-73>
       Starting Chef Client, version 12.18.31
       Creating a new client identity for node-centos-73 using the validator key.
       resolving cookbooks for run list: ["kubernete_deploy::node"]
       Synchronizing Cookbooks:
         - kubernete_deploy (0.1.0)
       Installing Cookbook Gems:
       Compiling Cookbooks...
       Converging 11 resources
       Recipe: kubernete_deploy::packages
         * yum_repository[kubernetes] action create
           * template[/etc/yum.repos.d/kubernetes.repo] action create
             - create new file /etc/yum.repos.d/kubernetes.repo
             - update content in file /etc/yum.repos.d/kubernetes.repo from none to f770eb
             --- /etc/yum.repos.d/kubernetes.repo	2017-02-03 12:20:17.565653624 +0000
             +++ /etc/yum.repos.d/.chef-kubernetes20170203-4116-y3lp5f.repo	2017-02-03 12:20:17.565653624 +0000
             @@ -1 +1,13 @@
             +# This file was generated by Chef
             +# Do NOT modify this file by hand.
             +
             +[kubernetes]
             +name=kubernetesrepo
             +baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
             +enabled=1
             +fastestmirror_enabled=0
             +gpgcheck=1
             +gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
             +       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
             +repo_gpgcheck=1
             - change mode from '' to '0644'
             - restore selinux security context
           * execute[yum-makecache-kubernetes] action run
             - execute yum -q -y makecache --disablerepo=* --enablerepo=kubernetes
           * ruby_block[yum-cache-reload-kubernetes] action create
             - execute the ruby block yum-cache-reload-kubernetes
           * execute[yum clean metadata kubernetes] action nothing (skipped due to action :nothing)
           * execute[yum-makecache-kubernetes] action nothing (skipped due to action :nothing)
           * ruby_block[yum-cache-reload-kubernetes] action nothing (skipped due to action :nothing)
         
         * remote_file[/etc/yum.repos.d/docker.repo] action create
           - create new file /etc/yum.repos.d/docker.repo
           - update content in file /etc/yum.repos.d/docker.repo from none to 97f61c
           --- /etc/yum.repos.d/docker.repo	2017-02-03 12:20:30.632852549 +0000
           +++ /tmp/chef-rest20170203-4116-1q9wzi	2017-02-03 12:20:30.631849740 +0000
           @@ -1 +1,28 @@
           +[docker-main]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/main/centos/7/
           +enabled=1
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           +
           +[docker-testing]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/testing/centos/$releasever/
           +enabled=0
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           +
           +[docker-beta]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/beta/centos/7/
           +enabled=0
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           +
           +[docker-nightly]
           +name=Docker Repository
           +baseurl=https://yum.dockerproject.org/repo/nightly/centos/7/
           +enabled=0
           +gpgcheck=1
           +gpgkey=https://yum.dockerproject.org/gpg
           - change mode from '' to '0644'
           - change owner from '' to 'root'
           - change group from '' to 'root'
           - restore selinux security context
         * execute[disable selinux - running] action run
           - execute setenforce 0
         * yum_package[docker-engine] action upgrade
           - upgrade package docker-engine from uninstalled to 1.13.0-1.el7.centos
         * yum_package[kubelet] action upgrade
           - upgrade package kubelet from uninstalled to 1.5.1-0
         * yum_package[kubeadm] action upgrade
           - upgrade package kubeadm from uninstalled to 1.6.0-0.alpha.0.2074.a092d8e0f95f52
         * yum_package[kubectl] action upgrade (up to date)
         * yum_package[kubernetes-cni] action upgrade (up to date)
         * service[kubelet] action enable
           - enable service service[kubelet]
         * service[kubelet] action start
           - start service service[kubelet]
         * service[docker] action enable
           - enable service service[docker]
         * service[docker] action start
           - start service service[docker]
       Recipe: kubernete_deploy::node
```

```
 kubernete_deploy]# kitchen list
Instance           Driver   Provisioner  Verifier  Transport  Last Action  Last Error
master-centos-73   Vagrant  ChefZero     Inspec    Ssh        Converged    <None>
node-centos-73     Vagrant  ChefZero     Inspec    Ssh        Converged    <None>
```




