class squid::services { 

  service { 'squid3':
    ensure    => running,
    enable    => true,
    subscribe => Class['squid::configuration'],
  }

}
