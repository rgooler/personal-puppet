class nginx::configuration { 

  file { '/etc/nginx/includes':
    ensure => directory,
  }

}
