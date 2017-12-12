node puppet.ruby {
  # Configure puppetdb and its underlying database
  class { 'puppetdb': }
  # Configure the Puppet master to use puppetdb
  class { 'puppetdb::master::config': }
  # Configure puppet Master to checkout the repo and autosign new nodes
  class { 'mcpuppet': 
    repo_dir => "/etc/puppetlabs/code/environments/ruby",
    ensure   => latest,
    source   => 'git@github.com:pedrodparkes/DevOps-ruby.git',
    revision => 'master',
    autosign => true,
  }
}

node bastion.ruby {
  class { 'grafana': }
}

node jenkins.ruby {
}

node grafana.ruby {
}