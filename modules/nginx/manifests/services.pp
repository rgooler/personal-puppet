class nginx::services {

  service { 'nginx':
    ensure => running,
  }

}
