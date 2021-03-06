#!/bin/bash
green=`tput setaf 2`
reset=`tput sgr0`
if [ -d "/home/distelli" ]; then
echo "Distelli Agent Already ${green}Installed ${reset}"
else
echo "DistelliAccessToken: '9EMWDPQZ9KVJ0E5242E54D9I3'" > /etc/distelli.yml
echo "DistelliSecretKey: 'jzjjpiemik98mj9i5aubwvzj03oftx2gjz4cr'" >> /etc/distelli.yml
echo "Environments:" >> /etc/distelli.yml
echo "  - Test" >> /etc/distelli.yml
cd ~
wget -qO- https://pipelines.puppet.com/download/client | sh
/usr/local/bin/distelli agent install -conf /etc/distelli.yml
/usr/local/bin/distelli login -conf /etc/distelli.yml
fi
cd ~
if [ -d "/etc/puppetlabs" ]; then
echo "Puppet Already ${green}Installed ${reset}"
else
yum install wget
wget https://s3.amazonaws.com/puppet-agents/2017.3/puppet-agent/5.3.5/repos/el/7/PC1/x86_64/puppet-agent-5.3.5-1.el7.x86_64.rpm
fi
cd /etc/puppetlabs/code/environments/production/modules/
git clone https://github.com/sidvenugop/helloworld
puppet apply --modulepath=/etc/puppetlabs/code/environments/production/modules -e "include helloworld" --noop
