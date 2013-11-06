class postfix::install { 

  package { 'postfix':
    ensure => latest,
  }

}
