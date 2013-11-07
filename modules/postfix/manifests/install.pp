class postfix::install { 

  package { 'postfix':
    ensure => latest,
  }

  package { 'postgrey':
    ensure  => latest,
    require => Package['postfix'],
  }

}
