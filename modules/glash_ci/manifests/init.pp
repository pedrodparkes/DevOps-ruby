class glash_ci (
    # $package_ensure = $ffmpeg::params::package_ensure,
    # $include_dev    = $ffmpeg::params::include_dev,
    # $include_dbg    = $ffmpeg::params::include_dbg,
  ) inherits glash_ci::params {


# include glash_ci::firewall_glash
include glash_ci::jenkins
#include glash_ci::webserver
#include glash_ci::cron


}