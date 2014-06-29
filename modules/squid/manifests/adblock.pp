class squid::adblock { 

  file { '/etc/squid3/squid.d/adblock.conf':
    ensure => file,
    source => 'puppet:///modules/squid/etc/squid3/squid.d/adblock.conf',
    notify => Class['squid::services'],
 }

 #$easylist = 'curl -q https://easylist-downloads.adblockplus.org/easylist.txt 2>/dev/null | sed -f /etc/squid3/lists/easylist2squid.sed >/etc/squid3/lists/easylist.txt'
 
 # I prefer the noadult filter, so here's an alternate link
 $easylist = 'curl -q https://easylist-downloads.adblockplus.org/easylist_noadult.txt 2>/dev/null | sed -f /etc/squid3/lists/easylist2squid.sed > /etc/squid3/lists/easylist.txt'

 better_cron { 'squid3_update_easylist':
   cron_minute => '0',
   cron_hour   => '5',
   cron_dow    => '0',
   path        => "${easylist}; service squid3 restart",
 }

 exec { $easylist : 
  unless  => '/etc/squid3/lists/easylist.txt',
  require => Class['squid::configuration'],
 }


}
