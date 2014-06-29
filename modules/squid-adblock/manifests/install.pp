class squid-adblock::install { 

  package { 'squid':
    ensure => latest,
  }

}
