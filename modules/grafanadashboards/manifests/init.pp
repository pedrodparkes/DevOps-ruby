# Class: grafanadashboards
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
#	class { 'grafanadashboards': 
#	    repo_dir => "/etc/puppetlabs/code/environments/moovcheckout",
#	    ensure   => latest,
#	    source   => 'git@github.com:moovweb/mc-puppet.git',
#	    revision => 'master',
#	    autosign => true,
#	  }
# Authors
# -------
# Vitalii Samotaiev <vsamotaiev@glash.io>

class grafanadashboards () inherits grafanadashboards::params {
	class { '::grafanadashboards::templates': }
}
