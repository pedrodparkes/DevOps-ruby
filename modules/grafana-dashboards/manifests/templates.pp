#== mcpuppet::config
#
class grafana-dashboards::templates inherits grafana-dashboard {

  file { '/etc/grafana/templates':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/grafana/templates':
    ensure  => directory,
    recurse => true,
    source  => "puppet:///modules/${module_name}/files",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}