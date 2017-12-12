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
}

node jenkins.ruby {
}

node grafana.ruby {
  class { 'grafana':
    cfg => {
      app_mode => 'production',
      server   => {
        http_port     => 8080,
      },
      database => {
        type          => 'sqlite3',
        host          => '127.0.0.1:3306',
        name          => 'grafana',
        user          => 'root',
        password      => '',
      },
      users    => {
        allow_sign_up => false,
      },
    },
  }
}