class squid::configuration { 

  file { '/etc/squid3/squid.conf':
    ensure => file,
    mode   => 0644,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/squid/etc/squid3/squid.conf',
  }

  file { '/etc/squid3/squid.d':
    ensure => directory,
 }

  file { '/etc/squid3/lists':
    ensure => directory,
    purge  => false,
    source => 'puppet:///modules/squid/etc/squid3/lists',
 }

}
