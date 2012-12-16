class virtualbox::install { 

  package { 'virtualbox-4.1':
    ensure => present,
  }

}
