class glash_ci::cron {

  cron { 'apply_puppet':
    command => 'puppet apply /etc/puppet/manifests/site.pp',
    ensure  => present,
    user    => 'root',
    hour    => '*',
    minute  => '15',
  }

#  class { 'cron': }
  # nginx::resource::upstream { 'jenkins':
  #   members => ['127.0.0.1:8080']
  # }
  # nginx::resource::vhost { 'jenkins.glash.io':
  #   proxy                      => 'http://jenkins',
  #   proxy_read_timeout         => '65s',
  #   proxy_connect_timeout      => '90',
  #   proxy_redirect             => 'default',
  #   proxy_set_header         =>   ['Host             $host', 'X-Real-IP        $remote_addr', 'X-Forwarded-For  $proxy_add_x_forwarded_for'],
  # }
}