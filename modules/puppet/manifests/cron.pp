class puppet::cron {

  include 'base::defines::better_cron'

  better_cron{ 'puppet':
    minute => fqdn_rand(60),
    path   => '/usr/local/sbin/update_puppet.sh',
  }

}
