#== mcpuppet::config
#
class grafanadashboards::templates inherits grafanadashboards {

  file { '/etc/grafana/templates':
    ensure  => directory,
    recurse => true,
    source  => "puppet:///modules/${module_name}",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}

$templates = ['aws-api-gateway.json', 'aws-autoscaling.json']

# function call with lambda:
$templates.each |String $template| {
  file {"/tmp/${template}":
    ensure => link,
    target => "/etc/grafana/templates/${template}",
  }
  grafana_dashboard { ${template}:
  grafana_url       => 'http://localhost:8080',
  grafana_user      => 'admin',
  grafana_password  => 'gfhfcjkmrf',
  content           => template('/etc/grafana/${template}'),
}
}