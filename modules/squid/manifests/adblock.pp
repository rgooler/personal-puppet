class squid::adblock { 

  file { '/usr/local/bin/easylist2squid.sh':
    ensure => file,
    mode   => 0755,
    source => 'puppet:///modules/squid/usr/local/bin/easylist2squid.sh',
  }

  file { '/etc/squid3/squid.d/adblock.conf':
    ensure => file,
    source => 'puppet:///modules/squid/etc/squid3/squid.d/adblock.conf',
    notify => Class['squid::services'],
 }


 better_cron { 'squid3_update_easylist':
   cron_minute => '0',
   cron_hour   => '5',
   cron_dow    => '0',
   path        => '/usr/local/bin/easylist2squid.sh && service squid3 restart',
 }

 exec { '/bin/bash /usr/local/bin/easylist2squid.sh' : 
  unless  => '/etc/squid3/lists/easylist.txt',
  require => Class['squid::configuration'],
 }


}
