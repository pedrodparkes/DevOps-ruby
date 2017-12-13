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
  -> class { 'nginx': }
  nginx::resource::upstream { 'grafana':
    members => ['localhost:8080'],
  }
  nginx::resource::server { 'grafana.glash.io':
    proxy => 'http://grafana',
    proxy_set_header         =>   ['Host             $host', 'X-Real-IP        $remote_addr', 'X-Forwarded-For  $proxy_add_x_forwarded_for'],
  }
  # class { 'influxdb':
  #     package => true,
  #     service => true,
  #   }
  class { 'apt':
  always_apt_update    => false,
  apt_update_frequency => undef,
  disable_keys         => undef,
  proxy_host           => false,
  proxy_port           => '8080',
  purge_sources_list   => false,
  purge_sources_list_d => false,
  purge_preferences_d  => false,
  update_timeout       => undef,
  fancy_progress       => undef
}
  -> grafana_datasource { 'influxdb':
    grafana_url       => 'http://localhost:8080',
    grafana_user      => 'admin',
    grafana_password  => 'gfhfcjkmrf',
    type              => 'influxdb',
    url               => 'http://localhost:8086',
    user              => 'admin',
    password          => 'gfhfcjkmrf',
    database          => 'graphite',
    access_mode       => 'proxy',
    is_default        => true,
    #json_data         => template('path/to/additional/config.json'),
  }
}