class phpvirtualbox::install { 
  $version = '4.2-4'

  file { "/var/www/phpvirtualbox-${version}":
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
    source  => "puppet:///modules/phpvirtualbox/var/www/phpvirtualbox-${version}",
  }

  file { '/var/www/virtualbox':
    ensure => link,
    target => "/var/www/phpvirtualbox-${version}",
  }

}
