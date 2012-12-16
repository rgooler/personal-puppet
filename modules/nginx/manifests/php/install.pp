class nginx::php::install {

  $packages = ['php5-fpm', 'php-pear', 'php5-common', 'php5-mysql', 'php-apc']

  package{ $packages:
    ensure => present,
  }

}
