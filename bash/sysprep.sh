#!/bin/bash
# Puppet agent install based on https://github.com/petems/puppet-install-shell
# Puppet_db and Puppet configuration based on puppetlabs-puppetdb module
ENVIRONMENT='ruby'
HOSTNAME='grafana'
DOMAIN='ruby'
# Make cloud-init stream logs to grub them from local PC with
# 
#exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "Upgrade Ubuntu"
apt-get update -y
apt-get upgrade -y
apt-get install links awscli -y
# Install puppet client
echo "Install puppet client"
wget -O - https://raw.githubusercontent.com/petems/puppet-install-shell/master/install_puppet_5_agent.sh | sudo sh
echo "Done: Install puppet client = $?"
echo "Fix puppet path"
cp /etc/environment /etc/environment.orig
echo "PATH=\"$PATH:/opt/puppetlabs/puppet/bin\"" > /etc/environment
source /etc/environment
#PATH=$PATH:/opt/puppetlabs/puppet/bin
#export PATH
echo "PATH=$PATH:/opt/puppetlabs/puppet/bin" >> /etc/profile
echo "export PATH" >> /etc/profile
#source /etc/profile
echo "Done: Fix puppet path =  $?"

echo "Set puppet conf"
cat << EOF > /etc/puppetlabs/puppet/puppet.conf
# Managed by AWS Userdata
[agent]
server = puppet.ruby
certname = $HOSTNAME.$DOMAIN
environment = $ENVIRONMENT
runinterval = 30m
EOF
echo "Set hostname"
echo "$HOSTNAME" > /etc/hostname
localIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "$localIP $HOSTNAME.$DOMAIN $HOSTNAME" >> /etc/hosts
hostname $HOSTNAME.$DOMAIN
echo "Enable puppet agent"
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
echo "Done: Enable puppet agent = $?"
#puppet agent -t --verbose --server puppet.ruby
echo "Done: Request certificate = $?"