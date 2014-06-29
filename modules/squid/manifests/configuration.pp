class squid::configuration { 

  file { '/etc/squid/squid3.conf':
    ensure => file
    mode   => 0644,
    user   => 'root',
    group  => 'root',
    source => 'puppet:///modules/squid/etc/squid/squid3.conf',
  }

  file { '/etc/squid/squid.d':
    ensure => directory,
 }

}
