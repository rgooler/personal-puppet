class deluge::install { 

  package { 'deluge':
    ensure => latest,
  }

  package { 'deluged':
    ensure => latest,
  }

  package { 'deluge-web':
    ensure => latest,
  }

}
