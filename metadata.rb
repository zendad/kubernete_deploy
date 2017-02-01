name 'kubernete_deploy'
maintainer 'Dereck Zenda'
maintainer_email 'dereck.zenda@gmail.com'
description 'Configures and installs Kubernetes'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

%w(redhat centos).each do |os|
  supports os, '>= 7.0'
end
