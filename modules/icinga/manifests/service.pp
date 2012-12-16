class icinga::service {

  service { 'fcgiwrap':
    ensure => running,
  }

  service { 'icinga':
    ensure => running,
  }

}
