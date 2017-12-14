#== mcpuppet::config
#
class grafanadashboards::templates inherits grafanadashboards {

  file { '/etc/grafana/templates':
    ensure  => directory,
    recurse => true,
    source  => "puppet:///modules/${module_name}/files",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}