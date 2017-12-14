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

#$templates = ['aws-api-gateway.json', 'aws-autoscaling.json']

#include grafana






grafana_dashboard { 'aws-api-gateway.json':
  grafana_url       => 'http://127.0.0.1:8080',
  grafana_user      => 'admin',
  grafana_password  => 'gfhfcjkmrf',
  content           => template('puppet:///modules/grafanadashboards/aws-api-gateway.json'),
}
# function call with lambda:
#$templates.each |String $template| {
#  grafana_dashboard { "${template}":
#    grafana_url       => 'http://localhost:8080',
#    grafana_password  => 'gfhfcjkmrf',
#    content           => template('/etc/grafana/${template}'),
#  }
#}
