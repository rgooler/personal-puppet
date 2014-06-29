class squid::configuration { 

  file { '/etc/squid3/squid.conf':
    ensure => file,
    mode   => 0644,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/squid3/etc/squid/squid.conf',
  }

  file { '/etc/squid3/squid.d':
    ensure => directory,
 }

}
