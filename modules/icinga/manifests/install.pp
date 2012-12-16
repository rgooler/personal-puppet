class icinga::install {
  include 'nginx::php'

  package { 'fcgiwrap':
    ensure => latest,
    notify => Class['nginx::services'],
  }

  package { 'icinga':
    ensure => latest,
  }

  package { 'icinga-doc':
    ensure  => latest,
    require => Package['icinga'],
  }

  package { 'pnp4nagios':
    ensure => latest,
  }

}
