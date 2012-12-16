class icinga::install {

  package { 'icinga':
    ensure => latest,
  }

  package { 'pnp4nagios':
    ensure => latest,
  }

}
