class nginx::php::services {

  service { 'php5-fpm':
    ensure    => running,
    subscribe => Class['nginx::php::configuration'],
  }

}
