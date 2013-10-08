class imagemagick::install { 

  package { 'imagemagick':
    ensure => latest,
  }

}
