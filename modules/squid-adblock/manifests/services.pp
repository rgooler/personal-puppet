class squid-adblock::services { 

  service { 'squid3':
    ensure    => running,
    enable    => true,
    subscribe => Class['squid-adblock::configuration'],
  }

}
