class squid::install { 

  package { 'squid':
    ensure => latest,
  }

}
