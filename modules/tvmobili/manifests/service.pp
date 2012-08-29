class tvmobili::service{
  
  service { 'tvmobilisvcd':
    ensure    => running,
    enable    => true,
    subscribe => Class['tvmobili::configuration'],
  }

}
