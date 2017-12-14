# Class: mcpuppet
# ===========================
# Parameters
# ----------
# $repo_dir = "/etc/puppetlabs/code/environments/dev"
# $ensure   = latest
# $source   = undef
# $revision = 'master'
# $autosign = false
# Examples
# --------
# @example
#	class { 'mcpuppet': 
#	    repo_dir => "/etc/puppetlabs/code/environments/moovcheckout",
#	    ensure   => latest,
#	    source   => 'git@github.com:moovweb/mc-puppet.git',
#	    revision => 'master',
#	    autosign => true,
#	  }
# Authors
# -------
# Vitalii Samotaiev <vsamotaiev@glash.io>

class grafana-dashboards () inherits grafana-dashboards::params {
	class { '::grafana-dashboards::templates': }
}