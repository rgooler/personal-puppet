class phpvirtualbox::install { 

  file { '/var/www/phpvirtualbox-4.1-8':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
    source  => "puppet://modules/phpvirtualbox/var/www/phpvirtualbox-4.1-8",
  }

  file { '/var/www/phpvirtualbox-4.1-11':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
    source  => "puppet://modules/phpvirtualbox/var/www/phpvirtualbox-4.1-11",
  }

  file { '/var/www/phpvirtualbox-4.2-4':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    recurse => true,
    source  => "puppet://modules/phpvirtualbox/var/www/phpvirtualbox-4.2-4",
  }

}
