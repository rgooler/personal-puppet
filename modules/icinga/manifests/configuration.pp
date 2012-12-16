class icinga::configuration {

  if ! defined(File['/etc/nginx/includes']) {
    file { '/etc/nginx/includes':
      ensure => directory,
    }
  }

  file { '/etc/nginx/includes/icinga.conf':
    ensure  => file,
    source  => 'puppet:///modules/icinga/etc/nginx/includes/icinga.conf',
    require => File['/etc/nginx/includes'],
  }

  file { '/etc/nginx/includes/pnp4nagios.conf':
    ensure => file,
    source => 'puppet:///modules/icinga/etc/nginx/includes/pnp4nagios.conf',
    require => File['/etc/nginx/includes'],
  }

  file { '/etc/nginx/includes/security.conf':
    ensure => file,
    source => 'puppet:///modules/icinga/etc/nginx/includes/security.conf',
    require => File['/etc/nginx/includes'],
  }

}
