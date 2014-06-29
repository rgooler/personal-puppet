class squid-adblock::configuration { 

  file { '/etc/squid/squid3.conf':
    ensure => file
    mode   => 0644,
    user   => 'root',
    group  => 'root',
    source => 'puppet:///modules/squid-adblock/etc/squid/squid3.conf',
  }

}
