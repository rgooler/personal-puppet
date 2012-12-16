class icinga::configuration {

  file { '/etc/nginx/conf.d/icinga.conf':
    ensure => file,
    source => 'puppet:///modules/icinga/etc/nginx/conf.d/icinga.conf',
  }

  file { '/etc/nginx/conf.d/pnp4nagios.conf':
    ensure => file,
    source => 'puppet:///modules/icinga/etc/nginx/conf.d/pnp4nagios.conf',
  }

  file { '/etc/nginx/conf.d/security.conf':
    ensure => file,
    source => 'puppet:///modules/icinga/etc/nginx/conf.d/security.conf',
  }

}
