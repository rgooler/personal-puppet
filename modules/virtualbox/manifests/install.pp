class virtualbox::install { 

  package { 'virtualbox-4.2':
    ensure => present,
  }

}
