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
  class { 'glash_ci': }
  -> class { 'nginx': }
  nginx::resource::upstream { 'jenkins':
    members => ['127.0.0.1:8080']
  }
  nginx::resource::server { 'jenkinsx.glash.io':
    proxy                      => 'http://jenkins',
    proxy_read_timeout         => '65s',
    proxy_connect_timeout      => '90',
    proxy_redirect             => 'default',
    proxy_set_header         =>   ['Host             $host', 'X-Real-IP        $remote_addr', 'X-Forwarded-For  $proxy_add_x_forwarded_for'],
  }
}

node grafana.ruby {

class {'influxdb::server':}

class { '::telegraf':
    hostname => $::hostname,
    outputs  => {
        'influxdb' => {
            'urls'     => [ "http://grafana.${::domain}:8086" ],
            'database' => 'telegraf',
            'username' => 'influx',
            'password' => 'influx_pass',
            }
        },
    inputs   => {
        'cpu' => {
            'percpu'   => true,
            'totalcpu' => true,
        },
    }
}

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
  -> class { 'grafanadashboards': }
  class { 'nginx': }
   nginx::resource::upstream { 'grafana':
     members => ['localhost:8080'],
   }
   nginx::resource::server { 'grafana.glash.io':
     proxy => 'http://grafana',
     proxy_set_header         =>   ['Host             $host', 'X-Real-IP        $remote_addr', 'X-Forwarded-For  $proxy_add_x_forwarded_for'],
   }
 
  grafana_datasource { 'influxdb':
     grafana_url       => 'http://127.0.0.1:8080',
     grafana_user      => 'admin',
     grafana_password  => 'gfhfcjkmrf',
     type              => 'influxdb',
     url               => 'http://localhost:8086',
     user              => 'influx',
     password          => 'influx_pass',
     database          => 'telegraf',
     access_mode       => 'proxy',
     is_default        => true,
     #json_data         => template('path/to/additional/config.json'),
   }

#grafana_dashboard { 'aws-api-gateway.json':
#  grafana_url       => 'http://127.0.0.1:8080',
#  grafana_user      => 'admin',
#  grafana_password  => 'gfhfcjkmrf',
#  content           => template('puppet:///modules/grafanadashboards/aws-api-gateway.json'),
#}

}
