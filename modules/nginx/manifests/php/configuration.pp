class nginx::php::configuration {

  file { '/etc/php5/fpm/pool.d/www.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/php5/fpm/pool.d/www.conf',
  }

  file { '/etc/nginx/conf.d/php':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/php',
  }

  file { '/etc/nginx/conf.d/wordpress':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/wordpress',
  }

}
